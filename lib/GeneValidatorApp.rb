require 'GeneValidatorApp/version'
require 'fileutils'


module GeneValidatorApp

  def create_unique_name
    puts 'creating a unique name'
    unique_name = Time.new.strftime('%Y-%m-%d_%H-%M-%S-%L-%N') + '_' + request.ip.gsub('.','-')
    return unique_name
  end

  def ensure_unique_name(working_folder, tempdir)
    puts 'Ensuring the run has a unique name'
    while File.exist?(working_folder)
      unique_name    = create_unique_name
      working_folder = File.join(@tempdir, @unique_name)
    end
    return unique_name
  end

  # Taken from SequenceServer
  def to_fasta(sequence)
    puts 'Converting Sequences to Fasta format if necessary.'
    sequence = sequence.lstrip
    unique_queries = Hash.new()
    if sequence[0,1] != '>'
      sequence.insert(0, ">Submitted at #{Time.now.strftime('%H:%M, %A, %B %d, %Y')}\n")
    end
    sequence.gsub!(/^\>(\S+)/) do |s|
      if unique_queries.has_key?(s)
        unique_queries[s] += 1
        s + '_' + (unique_queries[s]-1).to_s
      else
        unique_queries[s] = 1
        s
      end
    end
    return sequence
  end

  def create_fasta_file(working_folder, sequences)
    puts 'Writing the input sequences into a fasta file.'
    File.open(File.join(working_folder, "input_file.fa"), 'w+') do |f|
      f.write sequences
    end
  end

  def run_genevalidator (validation_array, database, working_folder, public_folder, unique_name)
    index_folder = File.join(working_folder, 'input_file.fa.html')

    puts 'Running Genevalidator from a sub-shell'
    command = "Genevalidator -v \"#{validation_array}\" -d \"#{database}\" #{working_folder}/input_file.fa"
    exit = system(command)
    raise IOError, "Genevalidator exited with the command code: #{exit}" unless exit

    html_table = extract_table_html(working_folder, public_folder, unique_name)

    return html_table
  end

  def extract_table_html(working_folder, public_folder, unique_name)
    index_file = File.join(working_folder, "/input_file.fa.html", "index.html")
    raise IOError, "GeneValidator has not created any results files..." unless File.exist?(index_file)

    puts 'Reading the html output file...'
    full_html = IO.binread(index_file)
    cleanhtml = full_html.gsub(/>\s*</, "><").gsub(/[\t\n]/, '').gsub('  ', ' ')
    cleanhtml.scan(/<div id="report">.*/) do |table|
      @html_table = table.gsub('</div></body></html>','').gsub(/input_file.fa_/, File.join('Genevalidator', unique_name, "/input_file.fa.html", 'input_file.fa_'))  # tYW instead modify GeneValidator. 
    end
    return @html_table
  end

  def create_results(insides)
    puts 'creating results'
    results = '<div id="results_box"><h2 class="page-header">Results</h2>'+ insides + '</div>'
    return results
  end
end
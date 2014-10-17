# GeneValidatorApp

This is a Sinatra based web wrapper for [GeneValidator](https://github.com/monicadragan/GeneValidator); a program that validates gene predictions.

## Installation

1. Install all GeneValidator Prerequisites (ruby <=1.9.3, Mafft, BLAST+). You would also require a BLAST database. Please see [here](https://gist.github.com/IsmailM/b783e8a06565197084e6) for more information.
<br>
2. Install GeneValidatorApp
<br>
    `$ gem install GeneValidatorApp`
<br>
3. Copy the examplar config file to your home directory. (The command to do this is shown by running genevalidatorapp)
  * Run GeneValidatorApp 
<br>
    `$ genevalidatorapp `
<br>
  * Run the command shown to copy the examplar config file to your home directory.
<br>
4. Set up variables in your config file.<br>
    `$ nano ~/genevalidatorapp.conf`
  * Set the `database-dir` variables to the full path to the directory containing your BLAST databases. 
  * Optional: set the `default-database` variable to the full path to the BLAST database that you would like to be your default database (otherwise genevalidator will randomly choose a default database for you). 

## Usage

After instaling simply type in:

	$ genevalidatorapp

and then go to [http://localhost:4567](http://localhost:4567) (if on a local server and using the default port: 4567)

See `genevalidator -h` for more information on how to run GeneValidatorApp.

## Contributing

1. Fork it ( https://github.com/IsmailM/GeneValidatorApp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

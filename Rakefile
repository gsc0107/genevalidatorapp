require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'

task default: [:build]

desc 'Builds and installs'
task install: [:build] do
  require_relative 'lib/genevalidatorapp/version'
  sh "gem install ./genevalidatorapp-#{GeneValidatorApp::VERSION}.gem"
end

desc 'Runs tests and builds gem (default)'
task build: [:test] do
  sh 'gem build genevalidatorapp.gemspec'
end



desc 'Runs tests'
task :test do
  Rake::TestTask.new do |t|
    t.libs.push 'lib'
    t.test_files = FileList['test/test_*.rb']
    t.verbose = false
    t.warning = false
  end
end
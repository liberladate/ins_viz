require 'rspec/core/rake_task'
require_relative 'tasks/packaging'
require_relative 'tasks/deploy'
require_relative 'tasks/data'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :run do
  sh 'rerun -- rackup'
end

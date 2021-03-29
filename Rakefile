# encoding: UTF-8

require 'rubygems'

require 'bundler/setup'
require 'bundler/cli'
require 'bundler/gem_tasks'

require 'rake/testtask'
require 'rake/notes/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test)

namespace :test do
  desc 'Run unit tests'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/**/*.rb'
  end

  desc 'Run integration tests'
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = 'spec/integration/**/*.rb'
  end

  desc 'Run legacy tests'
  RSpec::Core::RakeTask.new(:legacy) do |t|
    t.pattern = 'test/**/test_*.rb'
  end

  desc 'Run coding style tests'
  RSpec::Core::RakeTask.new(:cop) do
    Rake::Task['cop'].invoke
  end

  task :all => [:unit, :integration, :cop]
end

desc 'Run all tests'
task :test => 'test:all'

task :usage do
  puts 'No rake task specified, use rake -T to list them'
end

task :default => [:usage]

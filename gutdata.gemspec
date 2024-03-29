# encoding: utf-8
$LOAD_PATH.push File.expand_path('../lib/', __FILE__)
require 'gutdata/version'

Gem::Specification.new do |s|
  s.name = 'gutdata'
  s.version = GutData::VERSION
  s.licenses = ['BSD']

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = [
    'Pavel Kolesnikov',
    'Thomas Watson Steen',
    'Tomas Svarovsky',
    'Tomas Korcak'
  ]

  s.summary = 'A convenient Ruby wrapper around the GutData RESTful API'
  s.description = 'Use the GutData::Client class to integrate GutData into your own application or use the CLI to work with GutData directly from the command line.'
  s.email = 'pavel@gooddata.com'
  s.extra_rdoc_files = %w(LICENSE README.md)

  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.homepage = 'http://github.com/gooddata/gooddata-ruby'
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '>= 1.10.6'
  s.add_development_dependency 'debase', '~> 0.1', '>= 0.1.7' if !ENV['TRAVIS_BUILD'] && RUBY_VERSION >= '2.0.0'
  s.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  s.add_development_dependency 'rake-notes', '~> 0.2', '>= 0.2.0'
  s.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  s.add_development_dependency 'webmock', '~> 2.3.1'
  s.add_development_dependency 'yard', '~> 0.8.7.6'
  s.add_development_dependency 'yard-rspec', '~> 0.1'
  s.add_development_dependency 'ZenTest', '~> 4.10', '>= 4.11.0'

  s.add_dependency 'docile', '~> 1.1', '>= 1.1.5'
  s.add_dependency 'erubis', '~> 2.7', '>= 2.7.0'
  s.add_dependency 'gli', '~> 2.13', '>= 2.13.2'
  s.add_dependency 'hashie', '>= 1.2.0', '< 4.0'
  s.add_dependency 'highline', '~> 1.7', '>= 1.7.3'
  s.add_dependency 'json_pure', '~> 2.0'
  s.add_dependency 'multi_json', '~> 1.11', '>= 1.11.2'
  s.add_dependency 'parseconfig', '~> 1.0', '>= 1.0.6'
  s.add_dependency 'pmap', '~> 1.0', '>= 1.0.2'
  s.add_dependency 'pry', '~> 0.10', '>= 0.10.3'
  s.add_dependency 'rest-client', '>= 1.8.0', '< 2.1'
  s.add_dependency 'rubyzip', '~> 1.3'
  s.add_dependency 'terminal-table', '~> 3.0.2'
  s.add_dependency 'thread_safe'
end

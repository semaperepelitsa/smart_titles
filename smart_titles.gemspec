# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smart_titles/version"

Gem::Specification.new do |s|
  s.name        = "smart_titles"
  s.version     = SmartTitles::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Semyon Perepelitsa"
  s.email       = "sema@sema.in"
  s.homepage    = "http://github.com/semaperepelitsa/smart_titles"
  s.license     = "MIT"
  s.summary     = %q{Really convenient way to set up page titles in Rails application.}

  s.add_dependency 'activesupport'
  s.add_dependency 'actionpack'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

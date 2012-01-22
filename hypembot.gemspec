# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hypembot/version"

Gem::Specification.new do |s|
  s.name        = "hypembot"
  s.version     = Hypembot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kirk Scheibelhut"]
  s.email       = ["kjs@scheibo.com"]
  s.homepage    = "https://github.com/scheibo/hypembot"
  s.summary     = "Play music while browsing - have it appear in your Music folder."
  s.description = s.summary

  s.rubyforge_project = "hypembot"

  s.add_dependency "directory_watcher"
  s.add_dependency "eventmachine"
  s.add_dependency "growl"
  s.add_dependency "mp3info"

  s.add_development_dependency "rake"
  s.add_development_dependency "bundler", "~> 1.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable = 'hypembot'
  s.require_paths = ["lib"]
end

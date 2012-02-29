# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pacman/version"

Gem::Specification.new do |s|
  s.name        = "pacman"
  s.version     = Pacman::VERSION
  s.authors     = ["Jake Wilkins"]
  s.email       = ["jake.wilkins@adfitech.com"]
  s.homepage    = ""
  s.summary     = %q{Write a pacman PDF}
  s.description = %q{Write some pacmen}

  #s.rubyforge_project = "pacman"

  s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
   s.add_runtime_dependency "pdf-writer"
end

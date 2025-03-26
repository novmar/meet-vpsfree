# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'binman/version'

Gem::Specification.new do |s|
  s.name          = 'binman'
  s.version       = BinMan::VERSION
  s.authors,
  s.email         = File.read('LICENSE').scan(/Copyright \d+ (.+) <(.+?)>/).transpose
  s.homepage      = 'http://github.com/sunaku/binman'
  s.summary       = 'manpages from comment headers'
  s.description   = 'Produces UNIX manual pages for executable scripts.'

  s.files         = `git ls-files`.split("\n") + Dir['man/man?/*.?']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.files += Dir['man/man?/*.?']            # UNIX manual pages
  s.files += Dir['man/**/*.{html,css,js}']  # HTML manual pages
  s.add_development_dependency 'md2man', '~> 5.1'

  s.add_dependency 'opener', '>= 0.1.0', '< 1'
  s.add_development_dependency 'rake', '~> 10.1'
end

# -*- encoding: utf-8 -*-
# stub: binman 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "binman".freeze
  s.version = "5.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Suraj N. Kurapati".freeze]
  s.date = "2016-02-28"
  s.description = "Produces UNIX manual pages for executable scripts.".freeze
  s.email = ["sunaku@gmail.com".freeze]
  s.executables = ["binman".freeze, "binman-help".freeze, "binman-html".freeze, "binman-rake".freeze, "binman-roff".freeze, "binman-show".freeze, "binman-text".freeze]
  s.files = ["bin/binman".freeze, "bin/binman-help".freeze, "bin/binman-html".freeze, "bin/binman-rake".freeze, "bin/binman-roff".freeze, "bin/binman-show".freeze, "bin/binman-text".freeze]
  s.homepage = "http://github.com/sunaku/binman".freeze
  s.rubygems_version = "2.5.1".freeze
  s.summary = "manpages from comment headers".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<md2man>.freeze, ["~> 5.1".freeze])
  s.add_runtime_dependency(%q<opener>.freeze, [">= 0.1.0".freeze, "< 1".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.1".freeze])
end

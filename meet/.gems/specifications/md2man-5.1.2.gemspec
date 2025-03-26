# -*- encoding: utf-8 -*-
# stub: md2man 5.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "md2man".freeze
  s.version = "5.1.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Suraj N. Kurapati".freeze]
  s.date = "2018-02-04"
  s.description = "Converts markdown into UNIX manpages and HTML webpages.".freeze
  s.email = ["https://github.com/sunaku".freeze]
  s.executables = ["md2man-html".freeze, "md2man-rake".freeze, "md2man-roff".freeze]
  s.files = ["bin/md2man-html".freeze, "bin/md2man-rake".freeze, "bin/md2man-roff".freeze]
  s.homepage = "https://sunaku.github.io/md2man".freeze
  s.licenses = ["ISC".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.1".freeze)
  s.rubygems_version = "2.5.2.2".freeze
  s.summary = "markdown to manpage".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<binman>.freeze, ["~> 5.0".freeze])
  s.add_runtime_dependency(%q<redcarpet>.freeze, ["~> 3.0".freeze])
  s.add_runtime_dependency(%q<rouge>.freeze, ["~> 3.0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 12.0".freeze])
end

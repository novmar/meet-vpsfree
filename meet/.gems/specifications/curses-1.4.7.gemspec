# -*- encoding: utf-8 -*-
# stub: curses 1.4.7 ruby lib
# stub: ext/curses/extconf.rb

Gem::Specification.new do |s|
  s.name = "curses".freeze
  s.version = "1.4.7".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shugo Maeda".freeze, "Eric Hodel".freeze]
  s.date = "2024-10-22"
  s.email = ["shugo@ruby-lang.org".freeze, "drbrain@segment7.net".freeze]
  s.extensions = ["ext/curses/extconf.rb".freeze]
  s.files = ["ext/curses/extconf.rb".freeze]
  s.homepage = "https://github.com/ruby/curses".freeze
  s.licenses = ["Ruby".freeze, "BSD-2-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.5.9".freeze
  s.summary = "A Ruby binding for curses, ncurses, and PDCurses. curses is an extension library for text UI applications. Formerly part of the Ruby standard library, [curses was removed and placed in this gem][1] with the release of Ruby 2.1.0. (see [ruby/ruby@9c5b2fd][2])".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end

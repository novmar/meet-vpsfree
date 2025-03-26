# -*- encoding: utf-8 -*-
# stub: vpsadmin-client 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "vpsadmin-client".freeze
  s.version = "4.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jakub Skokan".freeze]
  s.date = "1980-01-01"
  s.description = "Ruby API and CLI for vpsAdmin API".freeze
  s.email = ["jakub.skokan@vpsfree.cz".freeze]
  s.executables = ["vpsadminctl".freeze]
  s.files = ["bin/vpsadminctl".freeze]
  s.homepage = "".freeze
  s.licenses = ["GPL".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.5.9".freeze
  s.summary = "Ruby API and CLI for vpsAdmin API".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<curses>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<haveapi-client>.freeze, ["~> 0.23.6".freeze])
  s.add_runtime_dependency(%q<json>.freeze, [">= 0".freeze])
end

# -*- encoding: utf-8 -*-
# stub: vpsfree-client 0.19.0 ruby lib

Gem::Specification.new do |s|
  s.name = "vpsfree-client".freeze
  s.version = "0.19.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jakub Skokan".freeze]
  s.date = "1980-01-01"
  s.description = "Ruby API and CLI for vpsFree.cz API".freeze
  s.email = ["jakub.skokan@vpsfree.cz".freeze]
  s.executables = ["vpsfreectl".freeze]
  s.files = ["bin/vpsfreectl".freeze]
  s.homepage = "".freeze
  s.licenses = ["GPL".freeze]
  s.rubygems_version = "3.5.9".freeze
  s.summary = "Ruby API and CLI for vpsFree.cz API".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<vpsadmin-client>.freeze, ["~> 4.0".freeze])
end

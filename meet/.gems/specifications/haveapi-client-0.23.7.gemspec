# -*- encoding: utf-8 -*-
# stub: haveapi-client 0.23.7 ruby lib

Gem::Specification.new do |s|
  s.name = "haveapi-client".freeze
  s.version = "0.23.7".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jakub Skokan".freeze]
  s.date = "1980-01-01"
  s.description = "Ruby API and CLI for HaveAPI".freeze
  s.email = ["jakub.skokan@vpsfree.cz".freeze]
  s.executables = ["haveapi-cli".freeze]
  s.files = ["bin/haveapi-cli".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.5.9".freeze
  s.summary = "Ruby API and CLI for HaveAPI".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 7.0".freeze])
  s.add_runtime_dependency(%q<highline>.freeze, ["~> 3.1".freeze])
  s.add_runtime_dependency(%q<json>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<require_all>.freeze, ["~> 2.0.0".freeze])
  s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 2.1.0".freeze])
  s.add_runtime_dependency(%q<ruby-progressbar>.freeze, ["~> 1.13.0".freeze])
end

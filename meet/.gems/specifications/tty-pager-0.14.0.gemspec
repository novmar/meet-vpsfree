# -*- encoding: utf-8 -*-
# stub: tty-pager 0.14.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-pager".freeze
  s.version = "0.14.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/piotrmurach/tty-pager/issues", "changelog_uri" => "https://github.com/piotrmurach/tty-pager/blob/master/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/tty-pager", "homepage_uri" => "https://ttytoolkit.org", "source_code_uri" => "https://github.com/piotrmurach/tty-pager" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-10-15"
  s.description = "A cross-platform terminal pager that works on all major Ruby interpreters.".freeze
  s.email = ["piotr@piotrmurach.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "CHANGELOG.md".freeze, "LICENSE.txt".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "https://ttytoolkit.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A cross-platform terminal pager that works on all major Ruby interpreters.".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<tty-screen>.freeze, ["~> 0.8".freeze])
  s.add_runtime_dependency(%q<strings>.freeze, ["~> 0.2.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 3.0".freeze])
end

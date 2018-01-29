# -*- encoding: utf-8 -*-
# stub: devise-specs 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "devise-specs".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrii Ponomarov".freeze]
  s.date = "2016-05-30"
  s.email = "andrii.ponomarov@gmail.com".freeze
  s.homepage = "https://github.com/andrii/devise-specs".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.7.4".freeze
  s.summary = "Generates the Devise acceptance tests.".freeze

  s.installed_by_version = "2.7.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<devise>.freeze, ["~> 4.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.1"])
      s.add_development_dependency(%q<aruba>.freeze, ["~> 0.14.1"])
    else
      s.add_dependency(%q<devise>.freeze, ["~> 4.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 11.1"])
      s.add_dependency(%q<aruba>.freeze, ["~> 0.14.1"])
    end
  else
    s.add_dependency(%q<devise>.freeze, ["~> 4.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.1"])
    s.add_dependency(%q<aruba>.freeze, ["~> 0.14.1"])
  end
end

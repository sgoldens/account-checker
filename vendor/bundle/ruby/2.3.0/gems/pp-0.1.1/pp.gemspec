# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pp/version'

Gem::Specification.new do |spec|
  spec.name          = "pp"
  spec.version       = Pp::VERSION
  spec.authors       = ["claudiob"]
  spec.email         = ["claudiob@gmail.com"]
  spec.description   = %q{Super Pretty Print}
  spec.summary       = %q{A Super Pretty Print}
  spec.homepage      = "https://www.github.com/claudiob/pp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end

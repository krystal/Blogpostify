# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blogpostify/version'

Gem::Specification.new do |spec|
  spec.name          = "blogpostify"
  spec.version       = Blogpostify::VERSION
  spec.authors       = ["Dan Wentworth"]
  spec.email         = ["dan@atechmedia.com"]
  spec.summary       = %q{Fetch, cache and display blog posts in your Rails app.}
  spec.homepage      = "https://github.com/darkphnx/Blogpostify"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rails", "~> 4"
end

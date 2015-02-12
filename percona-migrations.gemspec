# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'percona_migrations/version'

Gem::Specification.new do |spec|
  spec.name          = "percona-migrations"
  spec.version       = PerconaMigrations::VERSION
  spec.authors       = ["Sergey Varaksin"]
  spec.email         = ["varaksin86@gmail.com"]
  spec.summary       = %q{Allows to use percona in rails migrations.}
  spec.homepage      = "https://github.com/svarks/percona-migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 3.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'pry'
end

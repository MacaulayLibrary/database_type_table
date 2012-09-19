# -*- encoding: utf-8 -*-
require File.expand_path('../lib/database_type_table/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Maltzan"]
  gem.email         = ["brian.maltzan@gmail.com"]
  gem.description   = %q{Turn database rows into class constants}
  gem.summary       = %q{Turn database rows into class constants}
  gem.homepage      = "https://github.com/MacaulayLibrary/database_type_table"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "database_type_table"
  gem.require_paths = ["lib"]
  gem.version       = DatabaseTypeTable::VERSION
end

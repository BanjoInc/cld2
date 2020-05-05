# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cld/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alessandro Dal Grande", "Jason Toy"]
  gem.email         = ["jtoy@jtoy.net"]
  gem.description   = %q{Compact Language Detection for Ruby}
  gem.summary       = %q{Compact Language Detection for Ruby}
  gem.homepage      = "https://github.com/BanjoInc/cld2"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.extensions    = ["ext/cld/extconf.rb"]
  gem.name          = "cld2"
  gem.require_paths = ["lib"]
  gem.version       = CLD::VERSION

  gem.add_dependency "ffi", ">= 1.9.3", "< 2"

  gem.add_development_dependency "rspec", "~> 2.14.1"
end

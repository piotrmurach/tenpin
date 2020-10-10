# frozen_string_literal: true

require_relative "lib/tenpin/version"

Gem::Specification.new do |spec|
  spec.name          = "tenpin"
  spec.version       = Tenpin::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{A terminal tenpin bowling game.}
  spec.description   = %q{A terminal tenpin bowling game.}
  spec.homepage      = "https://github.com/piotrmurach/tenpin"
  spec.license       = "AGPL-3.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["bug_tracker_uri"] = "https://github.com/piotrmurach/tenpin/issues"
  spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/tenpin/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/tenpin"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/tenpin"

  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.bindir        = "exe"
  spec.executables   = %w[tenpin]
  spec.require_paths = ["lib"]

  spec.add_dependency "tty-box", "~> 0.5.0"
  spec.add_dependency "tty-cursor", "~> 0.7.0"
  spec.add_dependency "tty-reader", "~> 0.6.0"
  spec.add_dependency "tty-screen", "~> 0.7.0"
  spec.add_dependency "pastel", "~> 0.7.0"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end

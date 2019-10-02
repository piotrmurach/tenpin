lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tenpin/version"

Gem::Specification.new do |spec|
  spec.name          = "tenpin"
  spec.version       = Tenpin::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]
  spec.summary       = %q{A terminal tenpin bowling game.}
  spec.description   = %q{A terminal tenpin bowling game.}
  spec.homepage      = "https://github.com/piotrmurach/tenpin"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["bug_tracker_uri"] = "https://github.com/piotrmurach/tenpin/issues"
  spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/tenpin/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/tenpin"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/tenpin"

  spec.files         = Dir["lib/**/*.rb"]
  spec.files        += Dir["{tasks,bin,exe}/*", "tenpin.gemspec"]
  spec.files        += Dir["README.md", "CHANGELOG.md", "LICENSE.txt", "Rakefile"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tty-box", "~> 0.4.1"
  spec.add_dependency "tty-cursor", "~> 0.7.0"
  spec.add_dependency "tty-reader", "~> 0.6.0"
  spec.add_dependency "tty-screen", "~> 0.7.0"
  spec.add_dependency "pastel", "~> 0.7.0"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end

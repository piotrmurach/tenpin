source "https://rubygems.org"

gemspec

group :test do
  gem "benchmark-ips", "~> 2.7.2"
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.5.0")
    gem "coveralls_reborn", "~> 0.21.0"
    gem "simplecov", "~> 0.21.0"
  end
end

group :metrics do
  gem "yardstick", "~> 0.9.9"
end

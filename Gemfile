# frozen_string_literal: true

ruby file: ".ruby-version"

source "https://rubygems.org"

gemspec

group :quality do
  gem "caliber", "~> 0.83"
  gem "git-lint", "~> 10.0"
  gem "reek", "~> 6.5", require: false
  gem "simplecov", "~> 0.22", require: false
end

group :development do
  gem "rake", "~> 13.2"
end

group :test do
  gem "http-fake", "~> 5.0"
  gem "refinements", "~> 14.0"
  gem "rspec", "~> 3.13"
end

group :tools do
  gem "amazing_print", "~> 2.0"
  gem "debug", "~> 1.11"
  gem "irb-kit", "~> 2.0"
  gem "repl_type_completor", "~> 0.1"
end

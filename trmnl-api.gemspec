# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "trmnl-api"
  spec.version = "0.12.0"
  spec.authors = ["TRMNL"]
  spec.email = ["engineering@trmnl.com"]
  spec.homepage = "https://github.com/usetrmnl/trmnl-api"
  spec.summary = "A monadic TRMNL API client."
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/usetrmnl/trmnl-api/issues",
    "changelog_uri" => "https://github.com/usetrmnl/trmnl-api/tags",
    "homepage_uri" => "https://github.com/usetrmnl/trmnl-api",
    "label" => "TRMNL API",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/usetrmnl/trmnl-api"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = ">= 4.0"

  spec.add_dependency "cogger", "~> 2.0"
  spec.add_dependency "containable", "~> 2.0"
  spec.add_dependency "dry-monads", "~> 1.9"
  spec.add_dependency "dry-schema", "~> 1.14"
  spec.add_dependency "dry-types", "~> 1.8"
  spec.add_dependency "http", "~> 5.3"
  spec.add_dependency "infusible", "~> 5.0"
  spec.add_dependency "inspectable", "~> 1.0"
  spec.add_dependency "pipeable", "~> 2.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end

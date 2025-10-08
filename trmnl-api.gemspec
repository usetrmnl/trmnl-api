# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "trmnl-api"
  spec.version = "0.6.0"
  spec.authors = ["TRMNL"]
  spec.email = ["engineering@usetrmnl.com"]
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

  spec.required_ruby_version = "~> 3.4"

  spec.add_dependency "cogger", "~> 1.4"
  spec.add_dependency "containable", "~> 1.2"
  spec.add_dependency "dry-monads", "~> 1.8"
  spec.add_dependency "dry-schema", "~> 1.14"
  spec.add_dependency "http", "~> 5.3"
  spec.add_dependency "infusible", "~> 4.3"
  spec.add_dependency "inspectable", "~> 0.3"
  spec.add_dependency "openssl", "~> 3.3"
  spec.add_dependency "pipeable", "~> 1.3"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end

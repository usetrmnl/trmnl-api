# frozen_string_literal: true

require "dry/schema"
require "zeitwerk"

Dry::Schema.load_extensions :monads

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "api" => "API", "trmnl" => "TRMNL"
  loader.tag = "trmnl-api"
  loader.push_dir "#{__dir__}/.."
  loader.setup
end

module TRMNL
  # Main namespace.
  module API
    def self.loader registry = Zeitwerk::Registry
      @loader ||= registry.loaders.each.find { |loader| loader.tag == "trmnl-api" }
    end

    def self.new(&) = Client.new(&)
  end
end

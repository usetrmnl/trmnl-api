# frozen_string_literal: true

require "zeitwerk"

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
      @loader ||= registry.loaders.find { |loader| loader.tag == "trmnl-api" }
    end
  end
end

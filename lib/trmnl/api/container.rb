# frozen_string_literal: true

require "cogger"
require "containable"
require "http"

module TRMNL
  module API
    # Registers application dependencies.
    module Container
      extend Containable

      register(:settings) { TRMNL::API::Configuration::Loader.new.call }
      register(:requester) { API::Requester.new }
      register(:logger) { Cogger.new id: "trmnl-api", formatter: :json }

      register :http do
        HTTP.default_options = HTTP::Options.new features: {logging: {logger: self[:logger]}}
        HTTP
      end

      namespace :contracts do
        register :category, Contracts::Category
        register :current_screen, Contracts::CurrentScreen
        register :display, Contracts::Display
        register :firmware, Contracts::Firmware
        register :model, Contracts::Model
        register :setup, Contracts::Setup
      end

      namespace :models do
        register :current_screen, Models::CurrentScreen
        register :display, Models::Display
        register :firmware, Models::Firmware
        register :model, Models::Model
        register :setup, Models::Setup
      end
    end
  end
end

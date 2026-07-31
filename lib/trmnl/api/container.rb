# frozen_string_literal: true

require "cogger"
require "containable"
require "http"

module TRMNL
  module API
    # Registers application dependencies.
    module Container
      extend Containable[register: Containers::Register]

      register(:settings, as: :fresh) { TRMNL::API::Configuration::Loader.new.call }
      register(:requester) { API::Requester.new }
      register(:logger) { Cogger.new id: "trmnl-api", formatter: :json }

      register :http do
        settings = self[:settings]

        HTTP.timeout(settings.timeout)
            .headers(settings.headers)
            .use(logging: {logger: self[:logger]})
      end

      namespace :schemas do
        namespace :firmware do
          register :flash, Schemas::Firmware::Flash
          register :latest, Schemas::Firmware::Latest
        end

        register :category, Schemas::Category
        register :current_screen, Schemas::CurrentScreen
        register :display, Schemas::Display
        register :ip_address, Schemas::IPAddress
        register :model, Schemas::Model
        register :palette, Schemas::Palette
        register :recipe, Schemas::Recipe
        register :setup, Schemas::Setup
      end

      namespace :models do
        namespace :firmware do
          register :flash, Models::Firmware::Flash
          register :latest, Models::Firmware::Latest
        end

        register :current_screen, Models::CurrentScreen
        register :display, Models::Display
        register :ip_address, Models::IPAddress
        register :model, Models::Model
        register :palette, Models::Palette
        register :recipe, Models::Recipe
        register :setup, Models::Setup
      end
    end
  end
end

# frozen_string_literal: true

module TRMNL
  module API
    module Configuration
      # Loads configuration based on environment or falls back to defaults.
      class Loader
        def initialize model: Content, environment: ENV
          @model = model
          @environment = environment
        end

        def call
          model[
            content_type: environment.fetch("TRMNL_API_CONTENT_TYPE", "application/json"),
            uri: environment.fetch("TRMNL_API_URI", "https://trmnl.app/api")
          ]
        end

        private

        attr_reader :model, :environment
      end
    end
  end
end

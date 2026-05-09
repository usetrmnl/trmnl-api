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
            timeout_connect: environment.fetch("TRMNL_API_TIMEOUT_CONNECT", 2).to_i,
            timeout_read: environment.fetch("TRMNL_API_TIMEOUT_READ", 10).to_i,
            timeout_write: environment.fetch("TRMNL_API_TIMEOUT_WRITE", 10).to_i,
            uri: environment.fetch("TRMNL_API_URI", "https://trmnl.com/api"),
            user_agent: "http.rb/#{HTTP::VERSION} (#{default_user_agent})"
          ]
        end

        private

        attr_reader :model, :environment

        def default_user_agent
          environment.fetch "TRMNL_API_USER_AGENT", TRMNL::API.name.gsub("::", " ")
        end
      end
    end
  end
end

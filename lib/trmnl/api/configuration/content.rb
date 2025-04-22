# frozen_string_literal: true

module TRMNL
  module API
    module Configuration
      # Provides API client configuration content.
      Content = Struct.new :content_type, :uri do
        def headers = {"Content-Type" => content_type}.compact
      end
    end
  end
end

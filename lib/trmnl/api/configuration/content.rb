# frozen_string_literal: true

module TRMNL
  module API
    module Configuration
      # Provides API client configuration content.
      Content = Struct.new :content_type, :timeout_connect, :timeout_read, :timeout_write, :uri do
        def headers = {"Content-Type" => content_type}.compact

        def timeout = {connect: timeout_connect, read: timeout_read, write: timeout_write}
      end
    end
  end
end

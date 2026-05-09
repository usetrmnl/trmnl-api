# frozen_string_literal: true

require "http"

module TRMNL
  module API
    module Configuration
      # Provides API client configuration content.
      Content = Struct.new(
        :content_type,
        :timeout_connect,
        :timeout_read,
        :timeout_write,
        :uri,
        :user_agent
      ) do
        def headers
          agent = " (#{user_agent})" if user_agent
          {content_type: content_type, user_agent: "http.rb/#{HTTP::VERSION}#{agent}"}.compact
        end

        def timeout = {connect: timeout_connect, read: timeout_read, write: timeout_write}
      end
    end
  end
end

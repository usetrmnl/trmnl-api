# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      IPAddress = Dry::Schema.JSON do
        required(:data).hash do
          required(:ipv4).array(Types::IPAddress)
          required(:ipv6).array(Types::IPAddress)
        end
      end
    end
  end
end

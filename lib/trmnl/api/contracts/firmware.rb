# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      Firmware = Dry::Schema.JSON do
        required(:url).filled :string
        required(:version).filled :string
      end
    end
  end
end

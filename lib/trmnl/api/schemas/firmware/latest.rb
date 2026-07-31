# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      module Firmware
        # Validates API response.
        Latest = Dry::Schema.JSON do
          required(:url).filled :string
          required(:version).filled :string
        end
      end
    end
  end
end

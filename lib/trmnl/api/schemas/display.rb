# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      # Validates API response.
      Display = Dry::Schema.JSON do
        required(:action).filled :string
        required(:filename).filled :string
        required(:firmware_url).filled :string
        optional(:firmware_version).maybe :string
        required(:image_url).filled :string
        required(:refresh_rate).filled :integer
        required(:reset_firmware).filled :bool
        required(:update_firmware).filled :bool
      end
    end
  end
end

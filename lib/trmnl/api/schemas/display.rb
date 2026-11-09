# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      # Validates API response.
      Display = Dry::Schema.JSON do
        required(:filename).filled :string
        required(:image_url).filled :string
        optional(:image_url_timeout).filled :integer
        required(:refresh_rate).filled :integer
        optional(:firmware_version).filled :string
        required(:firmware_url).filled :string
        required(:reset_firmware).filled :bool
        required(:update_firmware).filled :bool
        optional(:maximum_compatibility).filled :bool
        optional(:temperature_profile).filled :string
        optional(:touchbar_mode).filled :string
        optional(:action).filled :string
        optional(:playlist_image_names).filled(:array).each(:string)
      end
    end
  end
end

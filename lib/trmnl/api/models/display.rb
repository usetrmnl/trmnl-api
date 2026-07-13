# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Display = Data.define(
        :filename,
        :firmware_url,
        :firmware_version,
        :image_url,
        :image_url_timeout,
        :maximum_compatibility,
        :refresh_rate,
        :reset_firmware,
        :special_function,
        :temperature_profile,
        :touchbar_mode,
        :update_firmware
      ) do
        def self.for(attributes) = new(**attributes)

        def initialize filename: nil,
                       firmware_url: nil,
                       firmware_version: nil,
                       image_url: nil,
                       image_url_timeout: 0,
                       maximum_compatibility: false,
                       refresh_rate: 300,
                       reset_firmware: false,
                       special_function: "none",
                       temperature_profile: "default",
                       touchbar_mode: "tap",
                       update_firmware: false
          super
        end

        def to_json(*) = to_h.to_json(*)
      end
    end
  end
end

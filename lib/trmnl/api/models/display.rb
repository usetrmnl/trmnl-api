# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Display = Data.define(
        :filename,
        :image_url,
        :image_url_timeout,
        :refresh_rate,
        :firmware_version,
        :firmware_url,
        :update_firmware,
        :reset_firmware,
        :maximum_compatibility,
        :temperature_profile,
        :touchbar_mode,
        :action,
        :playlist_image_names
      ) do
        def self.for(attributes) = new(**attributes)

        def initialize filename: nil,
                       image_url: nil,
                       image_url_timeout: 0,
                       refresh_rate: 300,
                       firmware_version: nil,
                       firmware_url: nil,
                       update_firmware: false,
                       reset_firmware: false,
                       maximum_compatibility: false,
                       temperature_profile: "default",
                       touchbar_mode: "tap",
                       action: nil,
                       playlist_image_names: nil
          super
        end

        def to_json(*) = to_h.to_json(*)
      end
    end
  end
end

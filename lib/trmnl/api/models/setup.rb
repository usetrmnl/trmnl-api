# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models API response.
      Setup = Data.define :api_key, :friendly_id, :image_url, :message do
        def self.for(attributes) = new(**attributes)
      end
    end
  end
end

# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      CurrentScreen = Data.define :refresh_rate, :image_url, :filename do
        def self.for(attributes) = new(**attributes)
      end
    end
  end
end

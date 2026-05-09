# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      LatestFirmware = ::Data.define :url, :version do
        def self.for(attributes) = new(**attributes)
      end
    end
  end
end

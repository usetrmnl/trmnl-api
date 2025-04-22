# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models API response.
      Firmware = Data.define :url, :version do
        def self.for(attributes) = new(**attributes)
      end
    end
  end
end

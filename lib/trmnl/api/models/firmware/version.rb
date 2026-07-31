# frozen_string_literal: true

module TRMNL
  module API
    module Models
      module Firmware
        # Models the data of the API response.
        Version = Data.define :label, :uri do
          def self.for(**attributes) = new(**attributes.transform_keys!(version: :label, url: :uri))
        end
      end
    end
  end
end

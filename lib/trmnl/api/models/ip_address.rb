# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      IPAddress = Data.define :version_4, :version_6 do
        def self.for attributes
          new(**attributes.transform_keys(ipv4: :version_4, ipv6: :version_6))
        end
      end
    end
  end
end

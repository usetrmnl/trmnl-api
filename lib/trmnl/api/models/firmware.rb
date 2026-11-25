# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Firmware = ::Data.define :label, :model_name, :chip_family, :version, :uri, :versions do
        def self.for **attributes
          versions = Array(attributes.delete(:versions)).map { Version.for(**it) }

          new(
            **attributes.transform_keys!(model: :model_name, latest: :version, url: :uri),
            versions:
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

require "core"

module TRMNL
  module API
    module Models
      module Firmware
        # Models the data of the API response.
        Flash = Data.define :name, :label, :chip_family, :versions do
          def self.for **attributes
            versions = Array(attributes.delete(:versions)).map { Version.for(**it) }
            new(**attributes.transform_keys!(keyname: :name, chipFamily: :chip_family), versions:)
          end

          def initialize name: nil, label: nil, chip_family: nil, versions: Core::EMPTY_ARRAY
            super
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require "core"
require "refinements/hash"

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Palette = Struct.new :name, :label, :grays, :colors, :framework_class do
        using Refinements::Hash

        def self.for(attributes) = new(**attributes.transform_keys(name: :label, id: :name))

        def initialize(**)
          super
          self[:grays] ||= 0
          self[:colors] ||= Core::EMPTY_ARRAY
          freeze
        end
      end
    end
  end
end

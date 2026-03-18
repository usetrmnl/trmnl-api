# frozen_string_literal: true

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
          self[:colors] ||= []
          freeze
        end
      end
    end
  end
end

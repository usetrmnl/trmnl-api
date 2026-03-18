# frozen_string_literal: true

require "refinements/hash"

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Palette = Struct.new :name, :label, :grays, :colors, :framework_class do
        using Refinements::Hash

        def self.for(attributes) = new(**attributes.transform_keys(name: :label, id: :name))
      end
    end
  end
end

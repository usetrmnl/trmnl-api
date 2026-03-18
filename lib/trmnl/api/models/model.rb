# frozen_string_literal: true

require "refinements/hash"

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Model = Struct.new(
        :name,
        :label,
        :description,
        :kind,
        :colors,
        :bit_depth,
        :scale_factor,
        :rotation,
        :mime_type,
        :width,
        :height,
        :offset_x,
        :offset_y,
        :palette_names,
        :css
      ) do
        def self.for(attributes) = new(**attributes.transform_keys(palette_ids: :palette_names))

        def initialize(**)
          super
          apply_defaults
          freeze
        end

        def to_json(*) = to_h.to_json(*)

        private

        def apply_defaults
          self[:palette_names] ||= []

          %i[colors bit_depth scale_factor rotation width height offset_x offset_y].each do |name|
            self[name] ||= 0
          end
        end
      end
    end
  end
end

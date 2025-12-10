# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models data for API display responses.
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
        :palette_ids,
        :css
      ) do
        def self.for(attributes) = new(**attributes)

        def initialize(**)
          super
          apply_defaults
          freeze
        end

        def to_json(*) = to_h.to_json(*)

        private

        def apply_defaults
          %i[colors bit_depth scale_factor rotation width height offset_x offset_y].each do |name|
            self[name] ||= 0
          end
        end
      end
    end
  end
end

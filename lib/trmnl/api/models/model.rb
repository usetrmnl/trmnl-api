# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models data for API display responses.
      Model = Struct.new(
        :name,
        :label,
        :description,
        :colors,
        :bit_depth,
        :scale_factor,
        :rotation,
        :mime_type,
        :width,
        :height,
        :offset_x,
        :offset_y,
        :published_at
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

# TODO: Remove when finished.
__END__

# frozen_string_literal: true

module Kagi
  module API
    module Models
      # Models the search payload.
      Search = Data.define :meta, :data do
        def self.for(**attributes)
          new(
            **attributes.merge!(
              meta: Content::Meta.for(**attributes[:meta]),
              data: attributes[:data].map { Content::Search.for(**it) }
            )
          )
        end
      end
    end
  end
end



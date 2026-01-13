# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Palette = Data.define :id, :name, :grays, :colors, :framework_class do
        def self.for(attributes) = new(**attributes)
      end
    end
  end
end

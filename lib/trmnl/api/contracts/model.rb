# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      Model = Dry::Schema.JSON do
        required(:data).array(:hash) do
          required(:name).filled :string
          required(:label).filled :string
          required(:description).filled :string
          required(:colors).filled :integer
          required(:bit_depth).filled :integer
          required(:scale_factor) { filled? > int? | float? }
          required(:rotation).filled :integer
          required(:mime_type).filled :string
          required(:width).filled :integer
          required(:height).filled :integer
          required(:offset_x).filled :integer
          required(:offset_y).filled :integer
          required(:published_at).filled :time
        end
      end
    end
  end
end

# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      Palette = Dry::Schema.JSON do
        required(:data).array(:hash) do
          required(:id).filled :string
          required(:name).filled :string
          optional(:grays).maybe :integer
          optional(:colors).maybe(:array)
          optional(:framework_class).maybe :string
        end
      end
    end
  end
end

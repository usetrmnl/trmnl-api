# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      # Validates API response.
      Firmware = Dry::Schema.JSON do
        required(:data).array(:hash) do
          required(:label).filled :string
          required(:model).filled :string
          required(:chip_family).filled :string
          required(:latest).filled :string
          required(:url).filled :string
          required(:versions).filled(:array).each(:hash) do
            required(:version).filled :string
            required(:url).filled :string
          end
        end
      end
    end
  end
end

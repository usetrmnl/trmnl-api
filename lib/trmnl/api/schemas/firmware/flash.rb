# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      module Firmware
        # Validates API response.
        Flash = Dry::Schema.JSON do
          required(:data).filled(:hash) do
            required(:models).filled(:array).each(:hash) do
              required(:keyname).filled :string
              required(:label).filled :string
              required(:chipFamily).filled :string
              required(:versions).filled(:array).each(:hash) do
                required(:version).filled :string
                required(:url).filled :string
              end
            end
          end
        end
      end
    end
  end
end

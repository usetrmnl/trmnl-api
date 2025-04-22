# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      CurrentScreen = Dry::Schema.JSON do
        required(:refresh_rate).filled :integer
        required(:image_url).filled :string
        required(:filename).filled :string
      end
    end
  end
end

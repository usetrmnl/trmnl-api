# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      Setup = Dry::Schema.JSON do
        required(:api_key).filled :string
        required(:friendly_id).filled :string
        required(:image_url).filled :string
        required(:message).filled :string
      end
    end
  end
end

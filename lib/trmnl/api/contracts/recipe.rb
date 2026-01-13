# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      # Validates API response.
      Recipe = Dry::Schema.JSON do
        required(:data).array(:hash) do
          required(:id).filled :integer
          required(:name).filled :string
          required(:screenshot_url).filled :string
          required(:published_at).filled :time
          optional(:icon_url).maybe :string
          optional(:icon_content_type).maybe :string
          required(:author_bio).maybe Recipes::Author
          required(:custom_fields).array(:hash)

          required(:stats).filled :hash do
            required(:installs).filled :integer
            required(:forks).filled :integer
          end
        end

        required(:total).filled :integer
        required(:from).filled :integer
        required(:to).filled :integer
        required(:per_page).filled :integer
        required(:current_page).filled :integer
        required(:prev_page_url).maybe :string
        required(:next_page_url).maybe :string
      end
    end
  end
end

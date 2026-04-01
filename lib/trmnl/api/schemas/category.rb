# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Schemas
      # Validates API response.
      Category = Dry::Schema.JSON { required(:data).array(:string) }
    end
  end
end

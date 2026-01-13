# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Recipe
        include TRMNL::API::Dependencies[
          :requester,
          contract: "contracts.recipe",
          model: "models.recipe"
        ]

        include Inspectable[contract: :type]
        include Pipeable

        def call(**)
          pipe(
            requester.get("recipes.json", **),
            try(:parse, catch: JSON::ParserError),
            validate(contract, as: :to_h),
            to(model, :for)
          )
        end
      end
    end
  end
end

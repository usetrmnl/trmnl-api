# frozen_string_literal: true

require "inspectable"
require "pipeable"
require "refinements/hash"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Recipe
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.recipe",
          model: "models.recipe"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        using Refinements::Hash

        def call(**parameters)
          parameters.transform_keys! sort: "sort-by"

          pipe(
            requester.get("recipes.json", **parameters),
            try(:parse, catch: JSON::ParserError),
            validate(schema, as: :to_h),
            to(model, :for)
          )
        end
      end
    end
  end
end

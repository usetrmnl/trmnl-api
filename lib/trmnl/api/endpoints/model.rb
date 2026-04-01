# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Model
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.model",
          model: "models.model"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        def call
          pipe(
            requester.get("models"),
            try(:parse, catch: JSON::ParserError),
            validate(schema, as: :to_h),
            as(:fetch, :data),
            map { |data| model.for(**data) }
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Display
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.display",
          model: "models.display"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        def call token:
          pipe requester.get("display", headers: {"Access-Token" => token}),
               try(:parse, catch: JSON::ParserError),
               validate(schema, as: :to_h),
               to(model, :for)
        end
      end
    end
  end
end

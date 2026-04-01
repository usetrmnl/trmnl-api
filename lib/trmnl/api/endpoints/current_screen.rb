# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class CurrentScreen
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.current_screen",
          model: "models.current_screen"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        def call token:
          pipe requester.get("current_screen", headers: {"Access-Token" => token}),
               try(:parse, catch: JSON::ParserError),
               validate(schema, as: :to_h),
               to(model, :for)
        end
      end
    end
  end
end

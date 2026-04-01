# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Firmware
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.firmware",
          model: "models.firmware"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        def call
          pipe requester.get("firmware/latest"),
               try(:parse, catch: JSON::ParserError),
               validate(schema, as: :to_h),
               to(model, :for)
        end
      end
    end
  end
end

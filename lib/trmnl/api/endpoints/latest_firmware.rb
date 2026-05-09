# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class LatestFirmware
        include TRMNL::API::Dependencies[
          :requester,
          schema: "schemas.latest_firmware",
          model: "models.latest_firmware"
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

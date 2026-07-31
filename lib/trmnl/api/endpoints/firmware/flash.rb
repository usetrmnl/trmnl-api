# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      module Firmware
        # Handles API request/response.
        class Flash
          include TRMNL::API::Dependencies[
            :requester,
            schema: "schemas.firmware.flash",
            model: "models.firmware.flash"
          ]

          include Inspectable[schema: :type]
          include Pipeable

          def call
            pipe(
              requester.get("firmware/flash"),
              try(:parse, catch: JSON::ParserError),
              validate(schema, as: :to_h),
              as(:fetch, :data, :models),
              as(:fetch, :models),
              map { |attributes| model.for(**attributes) }
            )
          end
        end
      end
    end
  end
end

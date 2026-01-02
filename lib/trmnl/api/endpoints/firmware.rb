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
          contract: "contracts.firmware",
          model: "models.firmware"
        ]

        include Inspectable[contract: :type]
        include Pipeable

        def call
          pipe requester.get("firmware/latest"),
               try(:parse, catch: JSON::ParserError),
               validate(contract, as: :to_h),
               to(model, :for)
        end
      end
    end
  end
end

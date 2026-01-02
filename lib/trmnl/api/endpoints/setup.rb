# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Setup
        include TRMNL::API::Dependencies[
          :requester,
          contract: "contracts.setup",
          model: "models.setup"
        ]

        include Inspectable[contract: :type]
        include Pipeable

        def call id:
          pipe requester.get("setup", headers: {"ID" => id}),
               try(:parse, catch: JSON::ParserError),
               validate(contract, as: :to_h),
               to(model, :for)
        end
      end
    end
  end
end

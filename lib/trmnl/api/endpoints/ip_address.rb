# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class IPAddress
        include TRMNL::API::Dependencies[
          :requester,
          contract: "contracts.ip_address",
          model: "models.ip_address"
        ]

        include Inspectable[contract: :class]
        include Pipeable

        def call
          pipe requester.get("ips"),
               try(:parse, catch: JSON::ParserError),
               validate(contract, as: :to_h),
               as(:fetch, :data),
               to(model, :for)
        end
      end
    end
  end
end

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
          schema: "schemas.ip_address",
          model: "models.ip_address"
        ]

        include Inspectable[schema: :type]
        include Pipeable

        def call
          pipe requester.get("ips"),
               try(:parse, catch: JSON::ParserError),
               validate(schema, as: :to_h),
               as(:fetch, :data),
               to(model, :for)
        end
      end
    end
  end
end

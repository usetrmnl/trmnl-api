# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Palette
        include TRMNL::API::Dependencies[
          :requester,
          contract: "contracts.palette",
          model: "models.palette"
        ]

        include Inspectable[contract: :class]
        include Pipeable

        def call
          pipe(
            requester.get("palettes"),
            try(:parse, catch: JSON::ParserError),
            validate(contract, as: :to_h),
            as(:fetch, :data),
            map { |data| model.for(**data) }
          )
        end
      end
    end
  end
end

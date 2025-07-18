# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Model
        include TRMNL::API::Dependencies[
          :requester,
          contract: "contracts.model",
          model: "models.model"
        ]

        include Inspectable[contract: :class]
        include Pipeable

        def call
          pipe(
            requester.get("models"),
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

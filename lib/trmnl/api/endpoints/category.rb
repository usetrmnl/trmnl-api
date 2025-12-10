# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Category
        include TRMNL::API::Dependencies[:requester, contract: "contracts.category"]

        include Inspectable[contract: :class]
        include Pipeable

        def call
          pipe(
            requester.get("categories"),
            try(:parse, catch: JSON::ParserError),
            validate(contract, as: :to_h),
            as(:fetch, :data)
          )
        end
      end
    end
  end
end

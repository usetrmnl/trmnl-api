# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Category
        include TRMNL::API::Dependencies[:requester, schema: "schemas.category"]

        include Inspectable[schema: :type]
        include Pipeable

        def call
          pipe(
            requester.get("categories"),
            try(:parse, catch: JSON::ParserError),
            validate(schema, as: :to_h),
            as(:fetch, :data)
          )
        end
      end
    end
  end
end

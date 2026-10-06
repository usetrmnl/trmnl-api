# frozen_string_literal: true

require "inspectable"
require "pipeable"

module TRMNL
  module API
    module Endpoints
      module Firmware
        # Handles API request/response.
        class Latest
          include TRMNL::API::Dependencies[
            :requester,
            schema: "schemas.firmware.latest",
            model: "models.firmware.latest"
          ]

          include Inspectable[schema: :type]
          include Pipeable

          ASSET_URI = "https://trmnl-fw.s3.us-east-2.amazonaws.com/%<model_name>s/FW%<version>s.bin"

          def initialize(asset_uri: ASSET_URI, **)
            @asset_uri = asset_uri
            super(**)
          end

          def call version = nil, model_name: "trmnl_og"
            pipe requester.get("firmware/latest"),
                 try(:parse, catch: JSON::ParserError),
                 validate(schema, as: :to_h),
                 fmap { transform_uri it, (version || it[:version]), model_name },
                 to(model, :for)
          end

          private

          attr_reader :asset_uri

          def transform_uri data, version, model_name
            data.merge! url: format(asset_uri, model_name:, version:), version:
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module TRMNL
  module API
    module Endpoints
      # Handles API request/response.
      class Log
        include Dependencies[:client]

        def call(token:, **) = client.post("log", headers: {"Access-Token" => token}, **)
      end
    end
  end
end

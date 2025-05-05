# frozen_string_literal: true

require "dry/monads"
require "http"

module TRMNL
  module API
    # Provides a low level configurable and monadic API client.
    # :reek:DataClump
    class Requester
      include Dependencies[:settings, :http]
      include Dry::Monads[:result]

      HEADERS = {}.freeze

      def initialize(**)
        super
        yield settings if block_given?
      end

      def get(path, headers: HEADERS, **params) = call(__method__, path, headers, params:)

      def post(path, headers: HEADERS, **json) = call(__method__, path, headers, json:)

      private

      attr_reader :settings, :http

      # rubocop:todo Metrics/ParameterLists
      def call method, path, headers, **options
        http.headers(settings.headers.merge(headers))
            .public_send(method, "#{settings.uri}/#{path}", options)
            .then { |response| response.status.success? ? Success(response) : Failure(response) }
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end

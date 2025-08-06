# frozen_string_literal: true

require "dry/monads"
require "http"

module TRMNL
  module API
    # Provides a low level configurable and monadic API client.
    class Requester
      include Dependencies[:settings, :http, :logger]
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

      def call method, path, headers, **options
        http.headers(settings.headers.merge(headers))
            .public_send(method, uri(path), options)
            .then { |response| response.status.success? ? Success(response) : Failure(response) }
      rescue HTTP::ConnectionError => error then handle_bad_connection path, error
      rescue HTTP::TimeoutError => error then handle_timeout path, error
      rescue OpenSSL::SSL::SSLError => error then handle_bad_ssl path, error
      end

      def uri(path) = "#{settings.uri}/#{path}"

      def handle_bad_connection path, error
        logger.debug { error.message }
        Failure "Unable to connect: #{uri(path).inspect}. Is the network intermittent or down?"
      end

      def handle_timeout path, error
        logger.debug { error.message }
        Failure "Connection timed out: #{uri(path).inspect}."
      end

      def handle_bad_ssl path, error
        logger.debug { error.message }
        Failure "Unable to secure connection: #{uri(path).inspect}. " \
                "Is your certificate or SSL valid?"
      end
    end
  end
end

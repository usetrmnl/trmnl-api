# frozen_string_literal: true

require "inspectable"

module TRMNL
  module API
    # Provides the primary client for making API requests.
    class Client
      include Dependencies[:settings]
      include Inspectable[:endpoints]

      ENDPOINTS = {
        categories: Endpoints::Category,
        current_screen: Endpoints::CurrentScreen,
        display: Endpoints::Display,
        firmware: Endpoints::Firmware,
        ip_addresses: Endpoints::IPAddress,
        log: Endpoints::Log,
        models: Endpoints::Model,
        palettes: Endpoints::Palette,
        recipes: Endpoints::Recipe,
        setup: Endpoints::Setup
      }.freeze

      def initialize(requester: Requester, endpoints: ENDPOINTS, **)
        super(**)

        yield settings if block_given?

        requester = requester.new(settings:)

        @endpoints = endpoints.each.with_object({}) do |(key, value), all|
          all[key] = value.new requester:
        end
      end

      def categories = endpoints.fetch(__method__).call

      def current_screen(**) = endpoints.fetch(__method__).call(**)

      def display(**) = endpoints.fetch(__method__).call(**)

      def firmware = endpoints.fetch(__method__).call

      def ip_addresses = endpoints.fetch(__method__).call

      def log(**) = endpoints.fetch(__method__).call(**)

      def models(**) = endpoints.fetch(__method__).call(**)

      def palettes = endpoints.fetch(__method__).call

      def recipes(**) = endpoints.fetch(__method__).call(**)

      def setup(**) = endpoints.fetch(__method__).call(**)

      private

      attr_reader :endpoints
    end
  end
end

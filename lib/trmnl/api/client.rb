# frozen_string_literal: true

require "inspectable"

module TRMNL
  module API
    # Provides the primary client for making API requests.
    class Client
      include Dependencies[:settings]

      include Endpoints::Dependencies[
        endpoint_categories: :categories,
        endpoint_current_screen: :current_screen,
        endpoint_display: :display,
        endpoint_firmware: :firmware,
        endpoint_ip_addresses: :ip_addresses,
        endpoint_log: :log,
        endpoint_models: :models,
        endpoint_setup: :setup
      ]

      include Inspectable[
        endpoint_categories: :class,
        endpoint_current_screen: :class,
        endpoint_display: :class,
        endpoint_firmware: :class,
        endpoint_ip_addresses: :class,
        endpoint_log: :class,
        endpoint_models: :class,
        endpoint_setup: :class
      ]

      def initialize(**)
        super
        yield settings if block_given?
      end

      def categories = endpoint_categories.call

      def current_screen(**) = endpoint_current_screen.call(**)

      def display(**) = endpoint_display.call(**)

      def firmware = endpoint_firmware.call

      def ip_addresses = endpoint_ip_addresses.call

      def log(**) = endpoint_log.call(**)

      def models(**) = endpoint_models.call(**)

      def setup(**) = endpoint_setup.call(**)
    end
  end
end

# frozen_string_literal: true

module TRMNL
  module API
    # Provides the primary client for making API requests.
    class Client
      include Dependencies[:settings]

      include Endpoints::Dependencies[
        endpoint_current_screen: :current_screen,
        endpoint_display: :display,
        endpoint_firmware: :firmware,
        endpoint_log: :log,
        endpoint_setup: :setup
      ]

      def initialize(**)
        super
        yield settings if block_given?
      end

      def current_screen(**) = endpoint_current_screen.call(**)

      def display(**) = endpoint_display.call(**)

      def firmware = endpoint_firmware.call

      def log(**) = endpoint_log.call(**)

      def setup(**) = endpoint_setup.call(**)
    end
  end
end

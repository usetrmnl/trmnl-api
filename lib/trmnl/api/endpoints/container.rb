# frozen_string_literal: true

require "containable"

module TRMNL
  module API
    module Endpoints
      # Registers all endpoints.
      module Container
        extend Containable

        register(:current_screen) { CurrentScreen.new }
        register(:display) { Display.new }
        register(:firmware) { Firmware.new }
        register(:log) { Log.new }
        register(:models) { Model.new }
        register(:setup) { Setup.new }
      end
    end
  end
end

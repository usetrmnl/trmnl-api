# frozen_string_literal: true

require "containable"

module TRMNL
  module API
    module Endpoints
      # Registers all endpoints.
      module Container
        extend Containable

        namespace :firmware do
          register(:flashes) { Firmwares::Flash.new }
          register(:latest) { Firmware.new }
        end

        register(:categories) { Category.new }
        register(:current_screen) { CurrentScreen.new }
        register(:display) { Display.new }
        register(:ip_addresses) { IPAddress.new }
        register(:log) { Log.new }
        register(:models) { Model.new }
        register(:palettes) { Palette.new }
        register(:recipes) { Recipe.new }
        register(:setup) { Setup.new }
      end
    end
  end
end

# frozen_string_literal: true

require "dry/types"
require "ipaddr"

module TRMNL
  module API
    # A collection of custom types.
    module Types
      include Dry.Types(default: :strict)

      CSSVariables = Dry::Types["array"].of(
        Dry::Types["array"].constrained(filled: true, size: 2).of(Dry::Types["coercible.string"])
      )

      IPAddress = Constructor IPAddr
    end
  end
end

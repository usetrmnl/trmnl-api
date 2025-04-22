# frozen_string_literal: true

require "infusible"

module TRMNL
  # Defines endpoint dependencies for automatic injection.
  module API
    Dependencies = Infusible[Container]
  end
end

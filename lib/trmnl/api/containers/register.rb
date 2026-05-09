# frozen_string_literal: true

require "containable"
require "refinements/array"

module TRMNL
  module API
    module Containers
      # A custom Containable register that allows specific dependencies to be overwritten.
      class Register < Containable::Register
        using Refinements::Array

        def initialize(*, allowed_keys: %w[http logger], **)
          super(*, **)
          @allowed_keys = allowed_keys
        end

        protected

        def check_duplicate key, namespaced_key
          return if allowed_keys.include? namespaced_key

          message = "Dependency is already registered: #{key.inspect}."

          fail KeyError, message if dependencies.key? namespaced_key
        end

        private

        attr_reader :allowed_keys
      end
    end
  end
end

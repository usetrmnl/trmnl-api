# frozen_string_literal: true

require "core"

module TRMNL
  module API
    module Models
      # Models the payload of the API response.
      Recipe = ::Data.define :data, :meta do
        def self.empty(meta: Recipes::Meta.new) = new(data: Core::EMPTY_ARRAY, meta:)

        def self.for(**attributes)
          meta = attributes.slice :from,
                                  :to,
                                  :current_page,
                                  :per_page,
                                  :total,
                                  :prev_page_url,
                                  :next_page_url

          data = attributes[:data].map { Recipes::Data.for(**it) }

          new meta: Recipes::Meta[**meta], data:
        end
      end
    end
  end
end

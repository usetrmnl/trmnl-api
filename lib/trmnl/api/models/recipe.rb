# frozen_string_literal: true

module TRMNL
  module API
    module Models
      # Models the data of the API response.
      Recipe = ::Data.define(
        :data,
        :total,
        :from,
        :to,
        :per_page,
        :current_page,
        :prev_page_url,
        :next_page_url
      ) do
        def self.for(**attributes)
          data = attributes[:data].map { Recipes::Data.for(**it) }
          new(**attributes.merge!(data:))
        end
      end
    end
  end
end

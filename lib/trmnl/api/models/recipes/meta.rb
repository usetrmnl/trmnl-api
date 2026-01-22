# frozen_string_literal: true

module TRMNL
  module API
    module Models
      module Recipes
        # Models the metadata of the API response.
        Meta = ::Data.define(
          :from,
          :to,
          :current_page,
          :per_page,
          :total,
          :prev_page_url,
          :next_page_url
        ) do
          def initialize from: 0,
                         to: 0,
                         current_page: 0,
                         per_page: 0,
                         total: 0,
                         prev_page_url: nil,
                         next_page_url: nil
            super
          end

          def more? = to.positive? && to < total

          def next_page = current_page + 1
        end
      end
    end
  end
end

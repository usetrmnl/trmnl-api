# frozen_string_literal: true

module TRMNL
  module API
    module Models
      module Recipes
        # Models the data of the API response.
        Entry = Struct.new(
          :id,
          :name,
          :icon_url,
          :icon_content_type,
          :screenshot_url,
          :author,
          :custom_fields,
          :statistics,
          :published_at
        ) do
          def self.for(**attributes)
            new(
              **attributes.merge!(
                author: Author.for(**attributes.delete(:author_bio)),
                statistics: Statistics[**attributes.delete(:stats)]
              )
            )
          end
        end
      end
    end
  end
end

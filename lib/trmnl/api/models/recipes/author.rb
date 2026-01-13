# frozen_string_literal: true

module TRMNL
  module API
    module Models
      module Recipes
        # Models the author of the API response.
        Author = Struct.new(
          :keyname,
          :name,
          :field_type,
          :category,
          :description,
          :description_locales,
          :email_address,
          :learn_more_url,
          :github_url,
          :youtube_url
        ) do
          def self.for(locale_reducer: LocaleReducer, **attributes)
            description_locales = locale_reducer.call attributes
            new(description_locales:, **attributes)
          end
        end
      end
    end
  end
end

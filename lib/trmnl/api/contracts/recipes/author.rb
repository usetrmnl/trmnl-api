# frozen_string_literal: true

require "dry/schema"

module TRMNL
  module API
    module Contracts
      module Recipes
        # Validates API response.
        Author = Dry::Schema.JSON do
          required(:keyname).filled :string
          required(:name).filled :string
          required(:field_type).filled :string
          optional(:category).filled :string
          optional(:description).filled :string
          optional(:"description-de").filled :string
          optional(:"description-nl").filled :string
          optional(:"description-fr").filled :string
          optional(:"description-en").filled :string
          optional(:"description-en-GB").filled :string
          optional(:"description-es-ES").filled :string
          optional(:"description-it").filled :string
          optional(:"description-no").filled :string
          optional(:"description-da").filled :string
          optional(:"description-ja").filled :string
          optional(:"description-de-AT").filled :string
          optional(:"description-ko").filled :string
          optional(:"description-sv").filled :string
          optional(:"description-pt-BR").filled :string
          optional(:"description-zh-HK").filled :string
          optional(:"description-pl").filled :string
          optional(:"description-uk").filled :string
          optional(:"description-zh-CN").filled :string
          optional(:"description-hu").filled :string
          optional(:"description-he").filled :string
          optional(:"description-sk").filled :string
          optional(:"description-ru").filled :string
          optional(:"description-is").filled :string
          optional(:"description-id").filled :string
          optional(:email_address).filled :string
          optional(:learn_more_url).filled :string
          optional(:github_url).filled :string
          optional(:youtube_url).filled :string
        end
      end
    end
  end
end

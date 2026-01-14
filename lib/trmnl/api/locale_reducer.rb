# frozen_string_literal: true

module TRMNL
  module API
    LocaleReducer = lambda do |attributes, prefix: "description-"|
      attributes.each.with_object({}) do |(key, value), all|
        next unless key.start_with? prefix

        attributes.delete key
        all[key.to_s.delete_prefix(prefix)] = value
      end
    end
  end
end

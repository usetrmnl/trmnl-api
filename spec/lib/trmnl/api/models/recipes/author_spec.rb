# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Recipes::Author do
  subject(:author) { described_class.new }

  describe ".for" do
    let :attributes do
      {
        name: "test",
        "description-de": "german",
        "description-nl": "dutch",
        "description-fr": "french"
      }
    end

    it "transforms description locales to hash by key only" do
      expect(described_class.for(**attributes)).to eq(
        described_class[
          name: "test",
          description_locales: {
            "de" => "german",
            "nl" => "dutch",
            "fr" => "french"
          }
        ]
      )
    end
  end
end

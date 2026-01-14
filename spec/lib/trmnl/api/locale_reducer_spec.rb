# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::LocaleReducer do
  subject(:reducer) { described_class }

  describe "#call" do
    let :attributes do
      {
        name: "test",
        "description-de": "german",
        "description-fr": "french",
        "description-en-GB": "united_kingdom"
      }
    end

    it "answers locales hash" do
      expect(reducer.call(attributes)).to eq(
        "de" => "german",
        "fr" => "french",
        "en-GB" => "united_kingdom"
      )
    end

    it "answers locales hash using custom prefix" do
      attributes = {test_de: "german", test_fr: "french"}
      expect(reducer.call(attributes, prefix: "test_")).to eq("de" => "german", "fr" => "french")
    end

    it "answers empty hash when there are no locales" do
      expect(reducer.call({one: 1, two: 2})).to eq({})
    end

    it "mutates input when locales exist" do
      original = attributes.dup
      expect(reducer.call(attributes)).not_to eq(original)
    end
  end
end

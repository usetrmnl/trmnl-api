# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Palette do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {
        id: "test",
        name: "Test",
        grays: 2,
        colors: %w[#000000 #FFFFFF],
        framework_class: "screen--1bit"
      }

      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end
end

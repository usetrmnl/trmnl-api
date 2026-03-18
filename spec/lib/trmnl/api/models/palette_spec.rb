# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Palette do
  subject(:model) { described_class.new }

  let :attributes do
    {
      name: "test",
      label: "Test",
      grays: 2,
      colors: %w[#000000 #FFFFFF],
      framework_class: "screen--1bit"
    }
  end

  describe ".for" do
    it "answers record for attributes" do
      api_attributes = {
        id: "test",
        name: "Test",
        grays: 2,
        colors: %w[#000000 #FFFFFF],
        framework_class: "screen--1bit"
      }

      expect(described_class.for(api_attributes)).to eq(described_class[**attributes])
    end
  end

  describe "#initalize" do
    it "answers default attributes" do
      expect(model).to have_attributes(grays: 0, colors: [])
    end

    it "answers custom attributes" do
      expect(described_class[**attributes]).to have_attributes(attributes)
    end

    it "is frozen" do
      expect(model.frozen?).to be(true)
    end
  end
end

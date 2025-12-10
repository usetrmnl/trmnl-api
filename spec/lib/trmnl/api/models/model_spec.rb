# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Model do
  subject(:model) { described_class.new }

  describe ".for" do
    let :attributes do
      {
        name: "test",
        label: "Test",
        description: "A test.",
        kind: "trmnl",
        colors: 2,
        bit_depth: 1,
        scale_factor: 1,
        rotation: 90,
        mime_type: "image/png",
        width: 800,
        height: 480,
        offset_x: 10,
        offset_y: 15,
        palette_ids: %w[bw grey-4],
        css: {
          classes: {
            device: "screen--v2",
            size: "screen--lg"
          },
          variables: [
            %w[--screen-w 1040px],
            %w[--screen-h 780px]
          ]
        }
      }
    end

    it "answers record for attributes" do
      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end

  describe "#initialize" do
    it "answers default attributes" do
      expect(model.to_h).to eq(
        name: nil,
        label: nil,
        description: nil,
        kind: nil,
        colors: 0,
        bit_depth: 0,
        scale_factor: 0,
        rotation: 0,
        mime_type: nil,
        width: 0,
        height: 0,
        offset_x: 0,
        offset_y: 0,
        palette_ids: nil,
        css: nil
      )
    end

    it "is frozen" do
      expect(model.frozen?).to be(true)
    end
  end

  describe "#to_json" do
    it "answers JSON" do
      payload = JSON model.to_json, symbolize_names: true

      expect(payload).to eq(
        name: nil,
        label: nil,
        description: nil,
        kind: nil,
        colors: 0,
        bit_depth: 0,
        scale_factor: 0,
        rotation: 0,
        mime_type: nil,
        width: 0,
        height: 0,
        offset_x: 0,
        offset_y: 0,
        palette_ids: nil,
        css: nil
      )
    end
  end
end

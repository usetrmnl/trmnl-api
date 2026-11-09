# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Display do
  subject(:model) { described_class.new }

  describe ".for" do
    let :attributes do
      {
        filename: "test.bmp",
        image_url: "https://test.io/images/test.bmp",
        image_url_timeout: 10,
        refresh_rate: 150,
        firmware_version: "1.4.8",
        firmware_url: "https://test.io/FW1.4.8.bin",
        update_firmware: true,
        reset_firmware: false,
        maximum_compatibility: false,
        temperature_profile: "default",
        touchbar_mode: "tap",
        action: nil,
        playlist_image_names: nil
      }
    end

    it "answers record for attributes" do
      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end

  describe "#initialize" do
    it "answers default attributes" do
      expect(model.to_h).to eq(
        filename: nil,
        image_url: nil,
        image_url_timeout: 0,
        refresh_rate: 300,
        firmware_version: nil,
        firmware_url: nil,
        update_firmware: false,
        reset_firmware: false,
        maximum_compatibility: false,
        temperature_profile: "default",
        touchbar_mode: "tap",
        action: nil,
        playlist_image_names: nil
      )
    end
  end

  describe "#to_json" do
    it "answers JSON" do
      payload = JSON model.to_json, symbolize_names: true

      expect(payload).to eq(
        filename: nil,
        image_url: nil,
        image_url_timeout: 0,
        refresh_rate: 300,
        firmware_version: nil,
        firmware_url: nil,
        update_firmware: false,
        reset_firmware: false,
        maximum_compatibility: false,
        temperature_profile: "default",
        touchbar_mode: "tap",
        action: nil,
        playlist_image_names: nil
      )
    end
  end
end

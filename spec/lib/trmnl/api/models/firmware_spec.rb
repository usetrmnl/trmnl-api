# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Firmware do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {
        label: "TRMNL X",
        model_name: "v2",
        chip_family: "ESP32-S3",
        latest: "1.2.3",
        url: "https://fw.trmnl.com/v2/FW1.2.3.bin",
        versions: [
          {
            version: "1.2.3",
            url: "https://fw.trmnl.com/v2/FW1.2.3.bin"
          }
        ]
      }

      expect(described_class.for(**attributes)).to eq(
        described_class[
          label: "TRMNL X",
          model_name: "v2",
          chip_family: "ESP32-S3",
          version: "1.2.3",
          uri: "https://fw.trmnl.com/v2/FW1.2.3.bin",
          versions: [
            TRMNL::API::Models::Version[
              label: "1.2.3",
              uri: "https://fw.trmnl.com/v2/FW1.2.3.bin"
            ]
          ]
        ]
      )
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Firmware::Flash do
  subject(:recipe) { described_class[**attributes] }

  describe ".for" do
    let :attributes do
      {
        keyname: "test",
        label: "Test",
        chipFamily: "Test Family",
        versions: [
          {
            version: "FW1.2.3",
            url: "https://test.io/FW1.5.6.bin"
          }
        ]
      }
    end

    it "answers record for attributes" do
      expect(described_class.for(**attributes)).to eq(
        described_class[
          name: "test",
          label: "Test",
          chip_family: "Test Family",
          versions: [
            TRMNL::API::Models::Firmware::Version[
              label: "FW1.2.3",
              uri: "https://test.io/FW1.5.6.bin"
            ]
          ]
        ]
      )
    end

    it "answers empty record when given no attributes" do
      expect(described_class.for).to eq(described_class.new)
    end
  end
end

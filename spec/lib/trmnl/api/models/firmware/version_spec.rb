# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Firmware::Version do
  subject(:version) { described_class[**attributes] }

  describe ".for" do
    let :attributes do
      {
        version: "FW1.2.3",
        uri: "https://test.io/FW1.5.6.bin"
      }
    end

    it "answers record for attributes" do
      expect(described_class.for(**attributes)).to eq(
        described_class[label: "FW1.2.3", uri: "https://test.io/FW1.5.6.bin"]
      )
    end
  end
end

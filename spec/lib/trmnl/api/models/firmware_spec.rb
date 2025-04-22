# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Firmware do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {url: "https://test.io/FW1.0.0.bin", version: "1.0.0"}
      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end
end

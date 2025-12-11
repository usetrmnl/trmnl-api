# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::IPAddress do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {ipv4: ["192.168.1.10"], ipv6: ["1a00:100:100:1000::1"]}

      expect(described_class.for(attributes)).to eq(
        described_class[
          version_4: ["192.168.1.10"],
          version_6: ["1a00:100:100:1000::1"]
        ]
      )
    end
  end
end

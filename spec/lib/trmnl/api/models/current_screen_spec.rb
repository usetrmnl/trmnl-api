# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::CurrentScreen do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {refresh_rate: 1, image_url: "https://test.io", filename: "test"}

      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end
end

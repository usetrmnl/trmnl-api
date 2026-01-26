# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Setup do
  describe ".for" do
    it "answers record for attributes" do
      attributes = {
        api_key: "abc",
        friendly_id: "10CBAF",
        image_url: "https://trmnl.com/images/logo.bmp",
        message: "Welcome!"
      }

      expect(described_class.for(attributes)).to eq(described_class[**attributes])
    end
  end
end

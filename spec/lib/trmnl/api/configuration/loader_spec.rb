# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Configuration::Loader do
  subject(:loader) { described_class.new environment: Hash.new }

  describe "#call" do
    it "answers default configuration when environment is unset" do
      expect(loader.call).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/json",
          uri: "https://trmnl.app/api"
        ]
      )
    end

    it "answers custom configuration when environment is set" do
      loader = described_class.new environment: {
        "TRMNL_API_CONTENT_TYPE" => "application/xml",
        "TRMNL_API_URI" => "https://api.trmnl.com"
      }

      expect(loader.call).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/xml",
          uri: "https://api.trmnl.com"
        ]
      )
    end
  end
end

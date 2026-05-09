# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Configuration::Loader do
  subject(:loader) { described_class.new environment: Hash.new }

  describe "#call" do
    it "answers default configuration when environment is unset" do
      expect(loader.call).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/json",
          timeout_connect: 2,
          timeout_read: 10,
          timeout_write: 10,
          uri: "https://trmnl.com/api"
        ]
      )
    end

    it "answers custom configuration when environment is set" do
      loader = described_class.new environment: {
        "TRMNL_API_CONTENT_TYPE" => "application/xml",
        "TRMNL_API_TIMEOUT_CONNECT" => "1",
        "TRMNL_API_TIMEOUT_READ" => "2",
        "TRMNL_API_TIMEOUT_WRITE" => "3",
        "TRMNL_API_URI" => "https://trmnl.com"
      }

      expect(loader.call).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/xml",
          timeout_connect: 1,
          timeout_read: 2,
          timeout_write: 3,
          uri: "https://trmnl.com"
        ]
      )
    end
  end
end

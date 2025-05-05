# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API do
  describe ".loader" do
    it "eager loads" do
      expectation = proc { described_class.loader.eager_load force: true }
      expect(&expectation).not_to raise_error
    end

    it "answers unique tag" do
      expect(described_class.loader.tag).to eq("trmnl-api")
    end
  end

  describe ".new" do
    include_context "with application dependencies"

    it "configures client" do
      described_class.new do |settings|
        settings.content_type = "application/json"
        settings.uri = "https://api.test.io"
      end

      expect(settings).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/json",
          uri: "https://api.test.io"
        ]
      )
    end

    it "answers client" do
      described_class.new
      expect(described_class.new).to be_a(TRMNL::API::Client)
    end
  end
end

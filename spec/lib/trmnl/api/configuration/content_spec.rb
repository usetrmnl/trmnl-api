# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Configuration::Content do
  subject :content do
    described_class[uri: "https://trmnl.app/api", content_type: "application/json"]
  end

  describe "#headers" do
    it "answers HTTP headers when defined" do
      expect(content.headers).to eq("Content-Type" => "application/json")
    end

    it "answers empty hash when none are available" do
      content.content_type = nil
      expect(content.headers).to eq({})
    end
  end
end

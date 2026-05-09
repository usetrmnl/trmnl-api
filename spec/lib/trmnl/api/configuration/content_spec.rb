# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Configuration::Content do
  using Refinements::Struct

  subject :content do
    described_class[
      content_type: "application/json",
      timeout_connect: 1,
      timeout_read: 2,
      timeout_write: 3,
      uri: "https://test.io",
      user_agent: "Test"
    ]
  end

  describe "#headers" do
    it "answers default headers when not defined" do
      content.with! content_type: nil, user_agent: nil
      expect(content.headers).to eq(user_agent: "http.rb/#{HTTP::VERSION}")
    end

    it "answers custom headers when defined" do
      expect(content.headers).to eq(
        content_type: "application/json",
        user_agent: "http.rb/#{HTTP::VERSION} (Test)"
      )
    end
  end

  describe "#timeout" do
    it "answers attributes" do
      expect(content.timeout).to eq(connect: 1, read: 2, write: 3)
    end
  end
end

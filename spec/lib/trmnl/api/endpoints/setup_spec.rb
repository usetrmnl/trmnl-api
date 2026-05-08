# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Setup do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/setup",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {
                                        api_key: "abc",
                                        friendly_id: "10CBAF",
                                        image_url: "https://trmnl.com/images/logo.bmp",
                                        message: "Welcome!"
                                      }.to_json,
                                      status: 200,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers record" do
        result = endpoint.call id: "ABC"

        expect(result).to be_success(
          TRMNL::API::Models::Setup[
            api_key: "abc",
            friendly_id: "10CBAF",
            image_url: "https://trmnl.com/images/logo.bmp",
            message: "Welcome!"
          ]
        )
      end
    end

    context "with failure" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/setup",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {error: "Danger!"}.to_json,
                                      status: 404,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers failure" do
        result = endpoint.call id: "ABC"
        expect(result).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection(schema: "Dry::Schema::JSON")
    end
  end
end

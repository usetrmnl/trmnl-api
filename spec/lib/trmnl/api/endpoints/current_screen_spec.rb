# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::CurrentScreen do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/current_screen",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {
                                        status: 200,
                                        refresh_rate: 3200,
                                        image_url: "https://test.io/images/test.bmp",
                                        filename: "test.bmp",
                                        rendered_at: nil
                                      }.to_json,
                                      status: 200,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers success" do
        result = endpoint.call token: "secret"

        expect(result).to be_success(
          TRMNL::API::Models::CurrentScreen[
            refresh_rate: 3200,
            image_url: "https://test.io/images/test.bmp",
            filename: "test.bmp"
          ]
        )
      end
    end

    context "with failure" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/current_screen",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {error: "Danger!"}.to_json,
                                      status: 404,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers failure" do
        expect(endpoint.call(token: "secret")).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection(schema: "Dry::Schema::JSON")
    end
  end
end

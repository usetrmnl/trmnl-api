# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Palette do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      before do
        response = HTTP::Response.new headers: {content_type: "application/json"},
                                      body: {
                                        data: [
                                          {
                                            id: "test",
                                            name: "Test",
                                            grays: 2,
                                            colors: ["#000000", "#FFFFFF"],
                                            framework_class: "screen--1bit"
                                          }
                                        ]
                                      }.to_json,
                                      status: 200,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers success" do
        expect(endpoint.call).to be_success(
          [
            TRMNL::API::Models::Palette[
              name: "test",
              label: "Test",
              grays: 2,
              colors: %w[#000000 #FFFFFF],
              framework_class: "screen--1bit"
            ]
          ]
        )
      end
    end

    context "with failure" do
      before do
        response = HTTP::Response.new headers: {content_type: "application/json"},
                                      body: {error: "Danger!"}.to_json,
                                      status: 404,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers failure" do
        expect(endpoint.call).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection(schema: "Dry::Schema::JSON")
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Model do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/models",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {
                                        data: [
                                          {
                                            name: "test",
                                            label: "Test",
                                            description: "A test.",
                                            kind: "trmnl",
                                            colors: 2,
                                            bit_depth: 1,
                                            scale_factor: 1,
                                            rotation: 90,
                                            mime_type: "image/png",
                                            width: 800,
                                            height: 480,
                                            offset_x: 10,
                                            offset_y: 15,
                                            palette_ids: %w[bw grey-4],
                                            css: {
                                              classes: {
                                                density: "screen--density-2x",
                                                device: "screen--v2",
                                                size: "screen--lg"
                                              },
                                              variables: [
                                                ["--screen-w", "1040px"],
                                                ["--screen-h", "780px"]
                                              ]
                                            }
                                          }
                                        ]
                                      }.to_json,
                                      status: 200,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers response" do
        result = endpoint.call

        expect(result).to be_success(
          [
            TRMNL::API::Models::Model[
              name: "test",
              label: "Test",
              description: "A test.",
              kind: "trmnl",
              colors: 2,
              bit_depth: 1,
              scale_factor: 1,
              rotation: 90,
              mime_type: "image/png",
              width: 800,
              height: 480,
              offset_x: 10,
              offset_y: 15,
              palette_names: %w[bw grey-4],
              css: {
                classes: {
                  density: "screen--density-2x",
                  device: "screen--v2",
                  size: "screen--lg"
                },
                variables: [
                  %w[--screen-w 1040px],
                  %w[--screen-h 780px]
                ]
              }
            ]
          ]
        )
      end
    end

    context "with failure" do
      before do
        response = HTTP::Response.new uri: "https://trmnl.com/api/models",
                                      headers: {content_type: "application/json"},
                                      verb: :get,
                                      body: {error: "Danger!"}.to_json,
                                      status: 404,
                                      version: 1.0

        allow(http).to receive(:get).and_return response
      end

      it "answers failure response" do
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

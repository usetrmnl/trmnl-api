# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Model do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/models" do
            headers["Content-Type"] = "application/json"
            status 200

            <<~JSON
              {
                "data": [
                  {
                    "name": "test",
                    "label": "Test",
                    "description": "A test.",
                    "kind": "trmnl",
                    "colors": 2,
                    "bit_depth": 1,
                    "scale_factor": 1,
                    "rotation": 90,
                    "mime_type": "image/png",
                    "width": 800,
                    "height": 480,
                    "offset_x": 10,
                    "offset_y": 15,
                    "published_at": "2025-07-16T18:18:11+00:00"
                  }
                ]
              }
            JSON
          end
        end
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
              published_at: Time.parse("2025-07-16T18:18:11+00:00")
            ]
          ]
        )
      end
    end

    context "with failure" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/models" do
            headers["Content-Type"] = "application/json"
            status 404

            <<~JSON
              {"error": "Danger!"}
            JSON
          end
        end
      end

      it "answers failure response" do
        result = described_class.new(requester:).call
        expect(result).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end

  describe "#inspect" do
    it_behaves_like "an inspectable endpoint", described_class.new
  end
end

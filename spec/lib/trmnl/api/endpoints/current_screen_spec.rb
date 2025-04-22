# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::CurrentScreen do
  subject(:endpoint) { described_class.new client: }

  include_context "with application dependencies"

  let(:client) { TRMNL::API::Client.new http: }

  describe "#call" do
    context "with success" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/current_screen" do
            headers["Content-Type"] = "application/json"
            status 200

            <<~JSON
              {
                "status": 200,
                "refresh_rate": 3200,
                "image_url": "https://test.io/images/test.bmp",
                "filename": "test.bmp",
                "rendered_at": null
              }
            JSON
          end
        end
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
      let :http do
        HTTP::Fake::Client.new do
          get "/api/current_screen" do
            headers["Content-Type"] = "application/json"
            status 404

            <<~JSON
              {"error": "Danger!"}
            JSON
          end
        end
      end

      it "answers error response" do
        result = described_class.new(client:).call token: "secret"
        expect(result).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end
end

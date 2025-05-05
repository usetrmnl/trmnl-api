# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Display do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/display" do
            headers["Content-Type"] = "application/json"
            status 200

            <<~JSON
              {
                "filename": "test.bmp",
                "firmware_url": "https://test.io/FW1.4.8.bin",
                "image_url": "https://test.io/images/test.bmp",
                "refresh_rate": 3200,
                "reset_firmware": false,
                "special_function": "restart_playlist",
                "status": 0,
                "update_firmware": true
              }
            JSON
          end
        end
      end

      it "answers response" do
        result = endpoint.call token: "secret"
        expect(result).to be_success(
          TRMNL::API::Models::Display[
            filename: "test.bmp",
            firmware_url: "https://test.io/FW1.4.8.bin",
            image_url: "https://test.io/images/test.bmp",
            refresh_rate: 3200,
            reset_firmware: false,
            special_function: "restart_playlist",
            update_firmware: true
          ]
        )
      end
    end

    context "with failure" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/display" do
            headers["Content-Type"] = "application/json"
            status 404

            <<~JSON
              {"error": "Danger!"}
            JSON
          end
        end
      end

      it "answers failure response" do
        result = described_class.new(requester:).call token: "secret"
        expect(result).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end
end

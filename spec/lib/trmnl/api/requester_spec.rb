# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Requester do
  using Refinements::Hash

  subject(:requester) { described_class.new http: }

  describe "#initialize" do
    it "initializes with block" do
      requester = described_class.new { |settings| settings.content_type = "application/xml" }
      body = requester.get("bogus").failure.to_s

      expect(body).to include("Not Found")
    end
  end

  describe "#get" do
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

      it "answers response" do
        response = requester.get "current_screen"
        payload = response.fmap(&:parse).bind(&:symbolize_keys!)

        expect(payload).to eq(
          status: 200,
          refresh_rate: 3200,
          image_url: "https://test.io/images/test.bmp",
          filename: "test.bmp",
          rendered_at: nil
        )
      end
    end

    context "with custom header" do
      let(:http) { class_spy HTTP, headers: HTTP }
      let(:response) { instance_spy HTTP::Response }

      it "includes custom header" do
        requester.get "current_screen", headers: {"ID" => "123"}

        expect(http).to have_received(:headers).with(
          "Content-Type" => "application/json",
          "ID" => "123"
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
              {
                "message": "Danger!"
              }
            JSON
          end
        end
      end

      it "answers failure response" do
        response = requester.get "current_screen"
        payload = response.alt_map { |result| result.parse.symbolize_keys! }

        expect(payload).to be_failure(message: "Danger!")
      end
    end
  end

  describe "#post" do
    let :http do
      HTTP::Fake::Client.new do
        post "/api/log" do
          headers["Content-Type"] = "application/json"
          status 204
        end
      end
    end

    it "answers response" do
      result = requester.post "log", log: {}
      expect(result.success.status).to eq(204)
    end
  end
end

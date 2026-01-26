# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Setup do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    context "with success" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/setup" do
            headers["Content-Type"] = "application/json"
            status 200

            <<~JSON
              {
                "api_key": "abc",
                "friendly_id": "10CBAF",
                "image_url": "https://trmnl.com/images/logo.bmp",
                "message": "Welcome!"
              }
            JSON
          end
        end
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
      let :http do
        HTTP::Fake::Client.new do
          get "/api/setup" do
            headers["Content-Type"] = "application/json"
            status 404

            <<~JSON
              {"error": "Danger!"}
            JSON
          end
        end
      end

      it "answers failure" do
        result = described_class.new(requester:).call id: "ABC"
        expect(result).to match(Failure(be_a(HTTP::Response)))
      end
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection(contract: "Dry::Schema::JSON")
    end
  end
end

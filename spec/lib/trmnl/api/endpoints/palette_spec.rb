# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Palette do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    let :http do
      HTTP::Fake::Client.new do
        get "/api/palettes" do
          headers["Content-Type"] = "application/json"
          status 200

          <<~JSON
            {
              "data": [
                {
                  "id": "test",
                  "name": "Test",
                  "grays": 2,
                  "colors": ["#000000", "#FFFFFF"],
                  "framework_class": "screen--1bit"
                }
              ]
            }
          JSON
        end
      end
    end

    it "answers success" do
      result = endpoint.call

      expect(result).to be_success(
        [
          TRMNL::API::Models::Palette[
            id: "test",
            name: "Test",
            grays: 2,
            colors: %w[#000000 #FFFFFF],
            framework_class: "screen--1bit"
          ]
        ]
      )
    end

    context "with failure" do
      let :http do
        HTTP::Fake::Client.new do
          get "/api/palettes" do
            headers["Content-Type"] = "application/json"
            status 404

            <<~JSON
              {"error": "Danger!"}
            JSON
          end
        end
      end

      it "answers failure" do
        result = described_class.new(requester:).call
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

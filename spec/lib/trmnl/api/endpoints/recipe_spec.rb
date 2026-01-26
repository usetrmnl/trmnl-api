# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Recipe do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let :requester do
    TRMNL::API::Requester.new http: do |settings|
      settings.uri = "https://trmnl.com"
    end
  end

  describe "#call" do
    context "with success" do
      let :http do
        HTTP::Fake::Client.new do
          get "/recipes.json" do
            headers["Content-Type"] = "application/json"
            status 200

            <<~JSON
              {
                "data": [
                  {
                    "id": 1,
                    "name": "test",
                    "screenshot_url": "https://screens.trmnl.io/test.png",
                    "published_at": "2026-01-02T03:04:05.000Z",
                    "custom_fields": [],
                    "author_bio": {
                      "keyname": "test",
                      "name": "Test",
                      "field_type": "author_bio"
                    },
                    "stats": {
                      "installs": 1,
                      "forks": 2
                    }
                  }
                ],
                "total": 2,
                "from": 1,
                "to": 2,
                "per_page": 25,
                "current_page": 1,
                "prev_page_url": null,
                "next_page_url": "/recipes.json?page=2"
              }
            JSON
          end
        end
      end

      it "answers record" do
        expect(endpoint.call.success).to match(
          TRMNL::API::Models::Recipe[
            data: [
              TRMNL::API::Models::Recipes::Data[
                id: 1,
                name: "test",
                published_at: Time.parse("2026-01-02T03:04:05.000Z"),
                screenshot_url: "https://screens.trmnl.io/test.png",
                author: TRMNL::API::Models::Recipes::Author[
                  keyname: "test",
                  name: "Test",
                  field_type: "author_bio",
                  description_locales: {}
                ],
                custom_fields: [],
                statistics: TRMNL::API::Models::Recipes::Statistics[installs: 1, forks: 2]
              ]
            ],
            meta: TRMNL::API::Models::Recipes::Meta[
              total: 2,
              from: 1,
              to: 2,
              per_page: 25,
              current_page: 1,
              prev_page_url: nil,
              next_page_url: "/recipes.json?page=2"
            ]
          ]
        )
      end
    end

    context "with failure" do
      let :http do
        HTTP::Fake::Client.new do
          get "/recipes.json" do
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

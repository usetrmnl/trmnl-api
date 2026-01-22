# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Recipe do
  describe ".for" do
    let :attributes do
      {
        data: [
          {
            id: 1,
            name: "Test",
            published_at: "2026-01-13T13:00:32.349Z",
            icon_url: "https://icons.trmnl.io/test.png",
            icon_content_type: "image/png",
            screenshot_url: "https://screens.trmnl.io/test.png",
            author_bio: {
              keyname: "test",
              name: "Test",
              field_type: "author_bio",
              description: "A test.",
              github_url: "https://github.com/test/test",
              learn_more_url: "https://test.info"
            },
            custom_fields: [
              {
                keyname: "test",
                name: "Test",
                field_type: "A test bio.",
                description: "Displays test data.",
                github_url: "https://github.com/test/test",
                learn_more_url: "https://test.info"
              }
            ],
            stats: {
              installs: 6,
              forks: 0
            }
          }
        ],
        total: 100,
        from: 1,
        to: 25,
        per_page: 25,
        current_page: 1,
        prev_page_url: nil,
        next_page_url: "/recipes.json?page=2"
      }
    end

    it "answers record for attributes" do
      expect(described_class.for(**attributes)).to eq(
        described_class[
          data: [
            TRMNL::API::Models::Recipes::Data[
              id: 1,
              name: "Test",
              published_at: "2026-01-13T13:00:32.349Z",
              icon_url: "https://icons.trmnl.io/test.png",
              icon_content_type: "image/png",
              screenshot_url: "https://screens.trmnl.io/test.png",
              author: TRMNL::API::Models::Recipes::Author[
                keyname: "test",
                name: "Test",
                field_type: "author_bio",
                description: "A test.",
                description_locales: {},
                github_url: "https://github.com/test/test",
                learn_more_url: "https://test.info"
              ],
              custom_fields: [
                {
                  keyname: "test",
                  name: "Test",
                  field_type: "A test bio.",
                  description: "Displays test data.",
                  github_url: "https://github.com/test/test",
                  learn_more_url: "https://test.info"
                }
              ],
              statistics: TRMNL::API::Models::Recipes::Statistics[installs: 6, forks: 0]
            ]
          ],
          total: 100,
          from: 1,
          to: 25,
          per_page: 25,
          current_page: 1,
          prev_page_url: nil,
          next_page_url: "/recipes.json?page=2"
        ]
      )
    end
  end
end

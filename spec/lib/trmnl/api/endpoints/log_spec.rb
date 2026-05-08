# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Log do
  subject(:endpoint) { described_class.new requester: }

  include_context "with application dependencies"

  let(:requester) { TRMNL::API::Requester.new http: }

  describe "#call" do
    before do
      response = HTTP::Response.new uri: "https://trmnl.com/api/log",
                                    headers: {content_type: "application/json"},
                                    verb: :post,
                                    body: {}.to_json,
                                    status: 204,
                                    version: 1.0

      allow(http).to receive(:post).and_return response
    end

    it "answers record" do
      result = endpoint.call token: "secret"
      expect(result.success.status).to eq(204)
    end
  end
end

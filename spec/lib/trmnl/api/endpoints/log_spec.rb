# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Endpoints::Log do
  subject(:endpoint) { described_class.new client: }

  include_context "with application dependencies"

  let(:client) { TRMNL::API::Client.new http: }

  describe "#call" do
    let :http do
      HTTP::Fake::Client.new do
        post "/api/log" do
          headers["Content-Type"] = "application/json"
          status 204
        end
      end
    end

    it "answers record" do
      result = endpoint.call token: "secret"
      expect(result.success.status).to eq(204)
    end
  end
end

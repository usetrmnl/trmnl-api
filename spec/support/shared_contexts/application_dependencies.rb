# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  let :settings do
    TRMNL::API::Configuration::Content[
      content_type: "application/json",
      timeout_connect: 2,
      timeout_read: 10,
      timeout_write: 10,
      uri: "https://trmnl.app/api",
      user_agent: "RSpec"
    ]
  end

  let(:logger) { Cogger.new id: "trmnl-api", io: StringIO.new, level: :debug }
  let(:http) { class_spy HTTP }

  before { TRMNL::API::Container.stub! settings:, http:, logger: }

  after { TRMNL::API::Container.restore }
end

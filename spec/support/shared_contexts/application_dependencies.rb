# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  let(:logger) { Cogger.new id: "trmnl-api", io: StringIO.new, level: :debug }

  before { TRMNL::API::Container.stub! http:, logger: }

  after { TRMNL::API::Container.restore }
end

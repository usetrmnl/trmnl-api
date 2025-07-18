# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Client do
  subject(:client) { described_class.new }

  include_context "with application dependencies"

  describe "#initialize" do
    it "answers original settings without block" do
      client

      expect(settings).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/json",
          uri: "https://trmnl.app/api"
        ]
      )
    end

    it "modifies settings with block" do
      described_class.new { |settings| settings.uri = "https://api.test.io" }

      expect(settings).to eq(
        TRMNL::API::Configuration::Content[
          content_type: "application/json",
          uri: "https://api.test.io"
        ]
      )
    end
  end

  describe "#current_screen" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::CurrentScreen }

    it "messages endpoint" do
      client = described_class.new endpoint_current_screen: endpoint
      expect(client.current_screen(token: "abc")).to have_received(:call).with(token: "abc")
    end
  end

  describe "#display" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::Display }

    it "messages endpoint" do
      client = described_class.new endpoint_display: endpoint
      expect(client.display(token: "abc")).to have_received(:call).with(token: "abc")
    end
  end

  describe "#firmware" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::Firmware }

    it "messages endpoint" do
      client = described_class.new endpoint_firmware: endpoint
      expect(client.firmware).to have_received(:call)
    end
  end

  describe "#log" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::Log }

    it "messages endpoint" do
      client = described_class.new endpoint_log: endpoint
      expect(client.log(token: "abc", log: {})).to have_received(:call).with(token: "abc", log: {})
    end
  end

  describe "#models" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::Model }

    it "messages endpoint" do
      client = described_class.new endpoint_models: endpoint
      expect(client.models).to have_received(:call).with(no_args)
    end
  end

  describe "#setup" do
    let(:endpoint) { instance_spy TRMNL::API::Endpoints::Setup }

    it "messages endpoint" do
      client = described_class.new endpoint_setup: endpoint
      expect(client.setup(id: "abc")).to have_received(:call).with(id: "abc")
    end
  end

  describe "#inspect" do
    it "answers endpoint classes" do
      expect(client.inspect).to include(
        "@endpoint_current_screen=TRMNL::API::Endpoints::CurrentScreen, " \
        "@endpoint_display=TRMNL::API::Endpoints::Display, " \
        "@endpoint_firmware=TRMNL::API::Endpoints::Firmware, " \
        "@endpoint_log=TRMNL::API::Endpoints::Log, " \
        "@endpoint_models=TRMNL::API::Endpoints::Model, " \
        "@endpoint_setup=TRMNL::API::Endpoints::Setup, "
      )
    end
  end
end

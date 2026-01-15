# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Client do
  subject(:client) { described_class.new endpoints: }

  include_context "with application dependencies"

  describe "#initialize" do
    subject(:client) { described_class.new }

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

  describe "#categories" do
    let(:endpoints) { {categories: class_double(TRMNL::API::Endpoints::Category, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Category }

    it "messages endpoint" do
      client.categories
      expect(instance).to have_received(:call)
    end
  end

  describe "#current_screen" do
    let :endpoints do
      {current_screen: class_double(TRMNL::API::Endpoints::CurrentScreen, new: instance)}
    end

    let(:instance) { instance_spy TRMNL::API::Endpoints::CurrentScreen }

    it "messages endpoint" do
      client.current_screen token: "abc"
      expect(instance).to have_received(:call).with(token: "abc")
    end
  end

  describe "#display" do
    let(:endpoints) { {display: class_double(TRMNL::API::Endpoints::Display, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Display }

    it "messages endpoint" do
      client.display token: "abc"
      expect(instance).to have_received(:call).with(token: "abc")
    end
  end

  describe "#firmware" do
    let(:endpoints) { {firmware: class_double(TRMNL::API::Endpoints::Firmware, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Firmware }

    it "messages endpoint" do
      client.firmware
      expect(instance).to have_received(:call)
    end
  end

  describe "#ip_addresses" do
    let(:endpoints) { {ip_addresses: class_double(TRMNL::API::Endpoints::IPAddress, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::IPAddress }

    it "messages endpoint" do
      client.ip_addresses
      expect(instance).to have_received(:call)
    end
  end

  describe "#log" do
    let(:endpoints) { {log: class_double(TRMNL::API::Endpoints::Log, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Log }

    it "messages endpoint" do
      client.log token: "abc", log: {}
      expect(instance).to have_received(:call).with(token: "abc", log: {})
    end
  end

  describe "#models" do
    let(:endpoints) { {models: class_double(TRMNL::API::Endpoints::Model, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Model }

    it "messages endpoint" do
      client.models
      expect(instance).to have_received(:call).with(no_args)
    end
  end

  describe "#palette" do
    let(:endpoints) { {palettes: class_double(TRMNL::API::Endpoints::Palette, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Palette }

    it "messages endpoint" do
      client.palettes
      expect(instance).to have_received(:call).with(no_args)
    end
  end

  describe "#recipe" do
    let(:endpoints) { {recipes: class_double(TRMNL::API::Endpoints::Recipe, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Recipe }

    it "messages endpoint" do
      client.recipes
      expect(instance).to have_received(:call).with(no_args)
    end
  end

  describe "#setup" do
    let(:endpoints) { {setup: class_double(TRMNL::API::Endpoints::Setup, new: instance)} }
    let(:instance) { instance_spy TRMNL::API::Endpoints::Setup }

    it "messages endpoint" do
      client.setup id: "abc"
      expect(instance).to have_received(:call).with(id: "abc")
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection({})
    end
  end
end

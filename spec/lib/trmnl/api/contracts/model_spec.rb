# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Contracts::Model do
  subject(:contract) { described_class }

  let :payload do
    {
      name: "test",
      label: "Test",
      description: "A test.",
      colors: 2,
      bit_depth: 1,
      scale_factor: 1,
      rotation: 90,
      mime_type: "image/png",
      width: 800,
      height: 480,
      offset_x: 10,
      offset_y: 15,
      published_at: "2025-07-16T18:18:11+00:00"
    }
  end

  describe "#call" do
    it "validates scale factor is an integer" do
      expect(contract.call(data: [payload]).to_monad).to be_success
    end

    it "checks scale factor is a float" do
      payload[:scale_factor] = 1.5
      expect(contract.call(data: [payload]).to_monad).to be_success
    end

    it "answers failure when scale factor is missing" do
      payload.delete :scale_factor

      expect(contract.call(data: [payload]).errors.to_h).to eq(
        data: {
          0 => {
            scale_factor: ["is missing"]
          }
        }
      )
    end
  end
end

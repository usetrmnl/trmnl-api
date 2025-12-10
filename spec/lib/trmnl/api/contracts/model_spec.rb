# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Contracts::Model do
  subject(:contract) { described_class }

  let :payload do
    {
      name: "test",
      label: "Test",
      description: "A test.",
      kind: "trmnl",
      colors: 2,
      bit_depth: 1,
      scale_factor: 1,
      rotation: 90,
      mime_type: "image/png",
      width: 800,
      height: 480,
      offset_x: 10,
      offset_y: 15,
      palette_ids: %w[bw grey-4],
      css: {
        classes: {
          device: "screen--v2",
          size: "screen--lg"
        },
        variables: [
          %w[--screen-w 1040px],
          %w[--screen-h 780px]
        ]
      },
      published_at: "2025-07-16T18:18:11+00:00"
    }
  end

  describe "#call" do
    it "answers valid payload" do
      expect(contract.call(data: [payload]).to_monad).to be_success
    end

    it "allows scale factor as float" do
      payload[:scale_factor] = 1.5
      expect(contract.call(data: [payload]).to_monad).to be_success
    end

    it "fails when scale factor is missing" do
      payload.delete :scale_factor

      expect(contract.call(data: [payload]).errors.to_h).to eq(
        data: {
          0 => {
            scale_factor: ["is missing"]
          }
        }
      )
    end

    it "fails when CSS variables are empty" do
      payload[:css][:variables] = []

      expect(contract.call(data: [payload]).errors.to_h).to eq(
        data: {
          0 => {
            css: {
              variables: ["must be filled"]
            }
          }
        }
      )
    end

    it "fails when CSS variables array size is greater than two" do
      payload[:css][:variables] = [[1, 2, 3]]

      expect(contract.call(data: [payload]).errors.to_h).to eq(
        data: {
          0 => {
            css: {
              variables: {
                0 => ["size must be 2"]
              }
            }
          }
        }
      )
    end
  end
end

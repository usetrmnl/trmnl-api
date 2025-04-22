# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Container do
  subject(:container) { described_class }

  describe ".[]" do
    it "answers HTTP" do
      expect(container[:http]).to eq(HTTP)
    end
  end
end

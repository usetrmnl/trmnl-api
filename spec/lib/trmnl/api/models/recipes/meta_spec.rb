# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Models::Recipes::Meta do
  subject(:meta) { described_class[**attributes] }

  let :attributes do
    {
      from: 1,
      to: 25,
      per_page: 25,
      current_page: 1,
      total: 200,
      prev_page_url: nil,
      next_page_url: "/recipes.json?page=2"
    }
  end

  describe "#initialize" do
    it "answers defaults" do
      expect(described_class.new).to eq(
        described_class[
          from: 0,
          to: 0,
          current_page: 0,
          per_page: 0,
          total: 0,
          prev_page_url: nil,
          next_page_url: nil
        ]
      )
    end
  end

  describe "#more?" do
    it "answers true when there are more pages" do
      expect(meta.more?).to be(true)
    end

    it "answers false when to is zero" do
      attributes[:to] = 0
      expect(meta.more?).to be(false)
    end

    it "answers false when there are no more pages" do
      attributes[:to] = 200
      expect(meta.more?).to be(false)
    end
  end

  describe "#next_page" do
    it "answers next page" do
      expect(meta.next_page).to eq(2)
    end
  end
end

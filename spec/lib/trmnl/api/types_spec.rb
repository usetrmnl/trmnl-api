# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Types do
  describe "CSSVariables" do
    subject(:type) { described_class::CSSVariables }

    it "answers primitive" do
      expect(type.primitive).to eq(Array)
    end

    it "answers array of CSS variables when valid" do
      variables = [%w[--screen-w 1040px], %w[--screen-h 780px]]
      expect(type.call(variables)).to eq(variables)
    end

    it "answers array of coerced strings when valid" do
      expect(type.call([[1, 2]])).to eq([%w[1 2]])
    end

    it "fails with empty constraint error" do
      expectation = proc { type.call [[]] }

      expect(&expectation).to raise_error(
        Dry::Types::ConstraintError,
        "[] violates constraints (filled?([]) AND size?(2, []) failed)"
      )
    end

    it "fails with size constraint error" do
      expectation = proc { type.call [[1, 2, 3]] }

      expect(&expectation).to raise_error(
        Dry::Types::ConstraintError,
        "[1, 2, 3] violates constraints (size?(2, [1, 2, 3]) failed)"
      )
    end
  end

  describe "IPAddress" do
    subject(:type) { described_class::IPAddress }

    it "answers primitive" do
      expect(type.primitive).to eq(IPAddr)
    end

    it "answers Version 4.0.0 address" do
      expect(type.call("10.10.1.5")).to eq(IPAddr.new("10.10.1.5"))
    end

    it "answers Version 6.0.0 address" do
      expect(type.call("111:a111:111:d1:0:1:111e:1111")).to eq(
        IPAddr.new("111:a111:111:d1:0:1:111e:1111")
      )
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe TRMNL::API::Containers::Register do
  subject(:register) { described_class.new }

  describe "#call" do
    before do
      register.call :http, %w[default cache]
      register.call :logger, %w[default cache]
      register.call :test, %w[default cache]
    end

    it "allows http key override" do
      register.call :http, :other
      expect(register.inspect).to include(%("http" => [:other, :cache]))
    end

    it "allows logger key override" do
      register.call :logger, :other
      expect(register.inspect).to include(%("logger" => [:other, :cache]))
    end

    it "fails with invalid override" do
      expectation = proc { register.call :test, :test }
      expect(&expectation).to raise_error(KeyError, "Dependency is already registered: :test.")
    end
  end
end

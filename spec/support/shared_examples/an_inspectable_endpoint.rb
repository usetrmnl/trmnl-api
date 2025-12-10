# frozen_string_literal: true

RSpec.shared_examples "an inspectable endpoint" do |target|
  it "answers contract class" do
    expect(target.inspect).to include("@contract=Dry::Schema::JSON")
  end
end

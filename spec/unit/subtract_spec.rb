# frozen_string_literal: true

RSpec.describe Tenpin::Position, "subtract" do
  it "subtracts two position objects" do
    pin_a = Tenpin::Position[2,3]
    pin_b = Tenpin::Position[4,5]

    expect(pin_b - pin_a).to eq(Tenpin::Position[2, 2])
  end

  it "subtracts a position tuple from a position" do
    pin_a = Tenpin::Position[4,5]
    pin_b = [2,3]

    expect(pin_a - pin_b).to eq(Tenpin::Position[2, 2])
  end

  it "can't add object" do
    pin_a = Tenpin::Position[2,3]
    pin_b = Object.new

    expect {
      pin_a - pin_b
    }.to raise_error(Tenpin::Error, "Cannot add #{pin_b.inspect}")
  end
end

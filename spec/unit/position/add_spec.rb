# frozen_string_literal: true

RSpec.describe Tenpin::Position, "add" do
  it "adds two position objects" do
    pin_a = Tenpin::Position[2,3]
    pin_b = Tenpin::Position[4,5]

    expect(pin_a + pin_b).to eq(Tenpin::Position[6, 8])
  end

  it "adds a position with a position tuple" do
    pin_a = Tenpin::Position[2,3]
    pin_b = [4,5]

    expect(pin_a + pin_b).to eq(Tenpin::Position[6, 8])
  end

  it "can't add object" do
    pin_a = Tenpin::Position[2,3]
    pin_b = Object.new

    expect {
      pin_a + pin_b
    }.to raise_error(Tenpin::Error, "Cannot add #{pin_b.inspect}")
  end
end

# frozen_string_literal: true

RSpec.describe Tenpin::Pins, "#remove" do
  it "removes existing pin" do
    pins = Tenpin::Pins.new(0, 0)
    pin = Tenpin::Pin.new(9,3)

    pins.remove(pin)

    expect(pins.size).to eq(9)
    expect(pins.collided).to eq([pin])
  end

  it "doesn't remove an unknown pin" do
    pins = Tenpin::Pins.new(3, 4)
    pin = Tenpin::Pin.new(9,3) # doesn't match any pins

    pins.remove(pin)

    expect(pins.size).to eq(10)
    expect(pins.collided).to eq([])
  end
end

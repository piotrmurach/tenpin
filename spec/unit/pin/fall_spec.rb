# frozen_string_literal: true

RSpec.describe Tenpin::Pin, "#fall" do
  let(:output) { StringIO.new }

  it "animates falling pin" do
    allow(Kernel).to receive(:sleep)
    pin = Tenpin::Pin.new(5, 5, enable_color: true)

    pin.fall(output)

    expect(output.string).to eq([
      "\e[6;6H",
      "\e[97;43m-\e[0m\e[1D",
      "\e[97;43m\\\e[0m\e[1D",
      "\e[97;43m|\e[0m\e[1D",
      "\e[97;43m/\e[0m\e[1D",
      "\e[97;43m-\e[0m\e[1D"
    ].join)
  end
end

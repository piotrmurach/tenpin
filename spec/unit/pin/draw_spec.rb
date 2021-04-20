# frozen_string_literal: true

RSpec.describe Tenpin::Pin, "#draw" do
  let(:output) { StringIO.new }
  let(:symbol) { Tenpin::Pin::SYMBOL }

  it "draws a pin at a position" do
    pin = Tenpin::Pin.new(0, 0, enable_color: true)

    pin.draw(output)

    expect(output.string).to eq([
      "\e[1;1H\e[97;43m#{symbol}\e[0m"
    ].join)
  end
end

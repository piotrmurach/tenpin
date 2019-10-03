# frozen_string_literal: true

RSpec.describe Tenpin::Pin, "#draw" do
  let(:output) { StringIO.new }

  it "draws a pin at a position" do
    pin = Tenpin::Pin.new(0, 0)

    pin.draw(output)

    expect(output.string).to eq([
      "\e[1;1H\e[97;43m¡\e[0m"
    ].join)
  end
end

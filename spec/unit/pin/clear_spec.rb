# frozen_string_literal: true

RSpec.describe Tenpin::Pin, "#clear" do
  let(:output) { StringIO.new }

  it "clears pin from the lane" do
    pin = Tenpin::Pin.new(0,0)

    pin.clear(output)

    expect(output.string).to eq("\e[1;1H\e[43m \e[0m")
  end
end

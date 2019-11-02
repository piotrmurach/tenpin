# frozen_string_literal: true

RSpec.describe Tenpin::InfoBox, "#draw" do
  let(:output) { StringIO.new }

  it "draws messages in location" do
    info = Tenpin::InfoBox.new(1, 2)

    info.draw("msg1", "msg2", canvas: output)

    expect(output.string).to eq([
      "\e[3;2Hmsg1\e[4;2Hmsg2"
    ].join)
  end
end

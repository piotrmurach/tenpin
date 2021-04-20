# frozen_string_literal: true

RSpec.describe Tenpin::SwingBar, "#draw" do
  let(:output) { StringIO.new }

  before {
    pastel = Pastel.new(enabled: true)
    allow(Pastel).to receive(:new).and_return(pastel)
  }

  it "draws swing bar advance position" do
    allow(Kernel).to receive(:sleep)
    bar = Tenpin::SwingBar.new(0, 0)

    bar.current = 0

    bar.draw(output)

    expect(output.string).to eq("\e[30;42m#{Tenpin::SwingBar::GRADIENT}\e[0m")
  end

  it "draws swing bar retract position" do
    allow(Kernel).to receive(:sleep)
    bar = Tenpin::SwingBar.new(0, 0, width: 5)

    bar.current = 6

    bar.draw(output)

    expect(output.string).to eq("\e[1D \e[1D")
  end
end

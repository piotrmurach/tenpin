# frozen_string_literal: true

RSpec.describe Tenpin::Bowler, "#draw" do
  let(:output) { StringIO.new }

  it "draws bowler inside the lane" do
    bowler = Tenpin::Bowler.new(0, 0)

    bowler.draw(output)

    expect(output.string).to eq("\e[1;2H\e[34;43mO\e[0m")
  end
end

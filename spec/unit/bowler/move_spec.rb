# frozen_string_literal: true

RSpec.describe Tenpin::Bowler, "#move" do
  let(:output) { StringIO.new }

  it "moves bowler by a vector" do
    bowler = Tenpin::Bowler.new(2, 3)

    bowler.move [2, 2]

    expect(bowler.pos.to_a).to eq([4, 5])
  end
end

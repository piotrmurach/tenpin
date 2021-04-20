# frozen_string_literal: true

RSpec.describe Tenpin::Bowler, "#clear" do
  let(:output) { StringIO.new }

  it "clears bowler from the lane" do
    bowler = Tenpin::Bowler.new(2, 3, enable_color: true)

    bowler.clear(output)

    expect(output.string).to eq("\e[4;4H\e[43m \e[0m")
  end
end

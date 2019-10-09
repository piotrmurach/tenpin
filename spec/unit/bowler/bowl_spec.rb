# frozen_string_literal: true

RSpec.describe Tenpin::Bowler, "#bowl" do
  let(:output) { StringIO.new }

  it "bowls a ball inside the lane" do
    bowler = Tenpin::Bowler.new(0, 0, offset: 3)

    bowler.bowl(output, delay: 0)

    expect(output.string).to eq([
      "\e[0;2H\e[30;43mo\e[0m",
      "\e[0;2H\e[30;43m \e[0m",
      "\e[-1;2H\e[30;43mo\e[0m",
      "\e[-1;2H\e[30;43m \e[0m",
      "\e[-2;2H\e[30;43mo\e[0m",
      "\e[-2;2H\e[30;43m \e[0m"
    ].join)
  end
end

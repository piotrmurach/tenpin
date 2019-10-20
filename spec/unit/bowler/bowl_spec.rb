# frozen_string_literal: true

RSpec.describe Tenpin::Bowler, "#bowl" do
  let(:output) { StringIO.new }

  it "bowls a straight ball inside the lane" do
    bowler = Tenpin::Bowler.new(0, 0, distance: 3)

    bowler.bowl(output, delay: 0, hook: 50, power: 100)

    expect(output.string).to eq([
      "\e[0;2H\e[30;43mo\e[0m",
      "\e[0;2H\e[30;43m \e[0m",
      "\e[-1;2H\e[30;43mo\e[0m",
      "\e[-1;2H\e[30;43m \e[0m",
      "\e[-2;2H\e[30;43mo\e[0m",
      "\e[-2;2H\e[30;43m \e[0m"
    ].join)
  end

  it "bowls a left hook ball inside the lane" do
    bowler = Tenpin::Bowler.new(0, 0, distance: 3)

    bowler.bowl(output, delay: 0, hook: 40, power: 100)

    expect(output.string).to eq([
      "\e[0;2H\e[30;43mo\e[0m",
      "\e[0;2H\e[30;43m \e[0m",
      "\e[-1;2H\e[30;43mo\e[0m",
      "\e[-1;2H\e[30;43m \e[0m",
      "\e[-2;2H\e[30;43mo\e[0m",
      "\e[-2;2H\e[30;43m \e[0m"
    ].join)
  end

  it "bowls outside of the lane" do
    bowler = Tenpin::Bowler.new(0, 0, distance: 3)

    bowler.bowl(output, delay: 0, hook: 100, power: 1)

    expect(output.string).to eq([
      "\e[0;3H\e[30;43mo\e[0m",
      "\e[0;3H\e[30;43m \e[0m",
      "\e[-1;6H\e[30;43mo\e[0m",
      "\e[-1;6H\e[30;43m \e[0m",
      "\e[-2;11H\e[30;43mo\e[0m"
    ].join)
  end
end

# frozen_string_literal: true

RSpec.describe Tenpin::Scoreboard, "#draw" do
  let(:output) { StringIO.new }

  it "draws score board without scores" do
    scoreboard = Tenpin::Scoreboard.new(0, 0, score: [])

    scoreboard.draw(output)

    expect(output.string).to eq([
      "\e[1;1H _____________________________\n",
      "\e[2;1H|__1__|__2__|__3__|__4__|__5__|\n",
      "\e[3;1H|   | |   | |   | |   | |   | |\n",
      "\e[4;1H|     |     |     |     |     |\n",
      "\e[5;1H|_____|_____|_____|_____|_____|\n",
      "\e[6;1H ______________________________\n",
      "\e[7;1H|__6__|__7__|__8__|__9__|__10__|\n",
      "\e[8;1H|   | |   | |   | |   | |  | | |\n",
      "\e[9;1H|     |     |     |     |      |\n",
      "\e[10;1H|_____|_____|_____|_____|______|\n"
    ].join)
  end

  it "draws score board with all scores" do
    score = [
      [3,4], [5,2], [3,7], [10,4], [2,2],
      [4,2], [5,5], [2,6], [10,6], [4,4]
    ]
    scoreboard = Tenpin::Scoreboard.new(0, 0, score: score)

    scoreboard.draw(output)

    expect(output.string).to eq([
      "\e[1;1H _____________________________\n",
      "\e[2;1H|__1__|__2__|__3__|__4__|__5__|\n",
      "\e[3;1H|  3|4|  5|2|  3|\\| 10|x|  2|2|\n",
      "\e[4;1H|    7|    7|   10|   14|    4|\n",
      "\e[5;1H|_____|_____|_____|_____|_____|\n",
      "\e[6;1H ______________________________\n",
      "\e[7;1H|__6__|__7__|__8__|__9__|__10__|\n",
      "\e[8;1H|  4|2|  5|\\|  2|6| 10|x| 4|4| |\n",
      "\e[9;1H|    6|   10|    8|   16|     8|\n",
      "\e[10;1H|_____|_____|_____|_____|______|\n"
    ].join)
  end
end

# frozen_string_literal: true

RSpec.describe Tenpin::Scoreboard, "#draw" do
  let(:output) { StringIO.new }

  it "draws score board without scores" do
    scoreboard = Tenpin::Scoreboard.new(0, 0, scores: [])

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
    scores = [
    # gutter        spare strike
      [7,0], [5,2], [3,7], [10], [2,2],
    #        spare  gutter  strike  spare
      [4,2], [5,5], [0,6], [0,10], [6,4,3]
    ]
    scoreboard = Tenpin::Scoreboard.new(0, 0, scores: scores)

    scoreboard.draw(output)

    expect(output.string).to eq([
      "\e[1;1H _____________________________\n",
      "\e[2;1H|__1__|__2__|__3__|__4__|__5__|\n",
      "\e[3;1H|  7|-|  5|2|  3|/|   |x|  2|2|\n",
      "\e[4;1H|    7|    7|   10|   10|    4|\n",
      "\e[5;1H|_____|_____|_____|_____|_____|\n",
      "\e[6;1H ______________________________\n",
      "\e[7;1H|__6__|__7__|__8__|__9__|__10__|\n",
      "\e[8;1H|  4|2|  5|/|  -|6|   |x| 6|/|3|\n",
      "\e[9;1H|    6|   10|    6|   10|    10|\n",
      "\e[10;1H|_____|_____|_____|_____|______|\n"
    ].join)
  end
end

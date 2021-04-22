# frozen_string_literal: true

RSpec.describe Tenpin::Scoreboard, "#draw" do
  let(:output) { StringIO.new }

  it "draws score board without scores" do
    stub_const("Points", Struct.new(:frames, :frame_totals))
    points = Points.new
    points.frames = []
    points.frame_totals = []
    scoreboard = Tenpin::Scoreboard.new(0, 0, score: points)

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
    stub_const("Points", Struct.new(:frames, :frame_totals))
    points = Points.new
    points.frames = [
    # gutter        spare strike
      [7, 0], [5, 2], [3, 7], [10], [2, 2],
    #        spare  gutter  spare  spare
      [4, 2], [5, 5], [0, 6], [0, 10], [6, 4, 3]
    ]
    points.frame_totals = [7, 14, 34, 48, 52, 58, 68, 74, 94, 107]
    scoreboard = Tenpin::Scoreboard.new(0, 0, score: points)

    scoreboard.draw(output)

    expect(output.string).to eq([
      "\e[1;1H _____________________________\n",
      "\e[2;1H|__1__|__2__|__3__|__4__|__5__|\n",
      "\e[3;1H|  7|-|  5|2|  3|/|   |x|  2|2|\n",
      "\e[4;1H|    7|   14|   34|   48|   52|\n",
      "\e[5;1H|_____|_____|_____|_____|_____|\n",
      "\e[6;1H ______________________________\n",
      "\e[7;1H|__6__|__7__|__8__|__9__|__10__|\n",
      "\e[8;1H|  4|2|  5|/|  -|6|  -|/| 6|/|3|\n",
      "\e[9;1H|   58|   68|   74|   94|   107|\n",
      "\e[10;1H|_____|_____|_____|_____|______|\n"
    ].join)
  end
end

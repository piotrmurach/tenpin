# frozen_string_literal: true

RSpec.describe Tenpin::Lane, "#draw" do
  let(:output) { StringIO.new }
  let(:gut) { Tenpin::Lane::GUTTER }

  it "draw main bowling lane" do
    lane = Tenpin::Lane.new(0, 0, enable_color: true)

    lane.draw(output)

    expected_output = [
      "\e[1;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[2;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[3;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[4;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[5;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[6;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[7;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[8;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[9;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[10;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[11;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[12;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[13;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[14;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[15;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[16;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[17;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[18;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[19;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[20;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[21;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[22;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[23;1H\e[30;47m#{gut}\e[0m\e[43m                 \e[0m\e[30;47m#{gut}\e[0m",
      "\e[24;1H\e[43m                   \e[0m",
      "\e[6;4H\e[30;43m^  ^  ^  ^  ^\e[0m",
      "\e[18;10H\e[30;43m^\e[0m",
      "\e[19;7H\e[30;43m^     ^\e[0m",
      "\e[20;4H\e[30;43m^           ^\e[0m"
    ].join

    expect(output.string).to eq(expected_output)
  end
end

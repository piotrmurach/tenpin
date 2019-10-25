# frozen_string_literal: true

RSpec.describe Tenpin::SplashScreen, "#draw" do
  let(:output) { StringIO.new }

  it "draws a splash screen info" do
    screen = Tenpin::SplashScreen.new(0,0)

    screen.draw(output)

    expected_string = <<-EOS
\e[2J\e[1;1H
\e[2;1H             .-.
\e[3;1H             \\ /      .-.
\e[4;1H             |_|  .-. \\ /
\e[5;1H             |=|  \\ / |_|
\e[6;1H            /   \\ |_| |=|
\e[7;1H           / (@) \\|=|/   \\    Welcome to Ten-Pin Bowling
\e[8;1H      ____ |     /   \\@)  \\
\e[9;1H    .'    '.    / (@) \\   |    by Pior Murach
\e[10;1H  / #       \\   |     |   |
\e[11;1H  |    o o  |'='|     |  /
\e[12;1H  \\     o   /    \\   /'='
\e[13;1H    '.____.'      '='
\e[14;1H
\e[15;1HUse LEFT ARROW, RIGHT ARROW keys to set the bowler position. 
\e[16;1H
\e[17;1HPress Ctrl+X or Q to exit at any point of the game.
\e[18;1H
\e[19;1HTo start bowling you need to set the power and swing angle.
\e[20;1HTo do this press Space/Enter key to fill up a bar and
\e[21;1Hagain to stop it.
\e[22;1H
\e[23;1H\e[32mPress any key to start the game!\e[0m
EOS

    expect(output.string).to eq(expected_string.chomp)
  end
end

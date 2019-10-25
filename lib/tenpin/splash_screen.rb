# frozen_string_literal: true

module Tenpin
  class SplashScreen < Entity
    def draw(canvas = $stdout)
      canvas.print cursor.clear_screen
      intro = <<-INTRO

             .-.
             \\ /      .-.
             |_|  .-. \\ /
             |=|  \\ / |_|
            /   \\ |_| |=|
           / (@) \\|=|/   \\    Welcome to Ten-Pin Bowling
      ____ |     /   \\@)  \\
    .'    '.    / (@) \\   |    by Pior Murach
  / #       \\   |     |   |
  |    o o  |'='|     |  /
  \\     o   /    \\   /'='
    '.____.'      '='

Use LEFT ARROW, RIGHT ARROW keys to set the bowler position. 

Press Ctrl+X or Q to exit at any point of the game.

To start bowling you need to set the power and swing angle.
To do this press Space/Enter key to fill up a bar and
again to stop it.

      INTRO
      intro.lines.each.with_index do |line, i|
        canvas.print cursor.move_to(pos.x, pos.y + i) + line
      end
      canvas.print cursor.move_to(pos.x, pos.y + intro.lines.size)
      canvas.print pastel.green("Press any key to start the game!")
    end
  end # SplashScreen
end # Tenpin

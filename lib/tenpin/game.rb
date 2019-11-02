# frozen_string_literal: true

require "pastel"
require "tty-box"
require "tty-cursor"
require "tty-reader"
require "tty-screen"

require_relative "bowler"
require_relative "lane"
require_relative "pins"
require_relative "position"
require_relative "score"
require_relative "scoreboard"
require_relative "splash_screen"
require_relative "swing_bar"

module Tenpin
  class Game
    attr_reader :rows, :cols, :cursor

    # Setup game
    #
    # @api public
    def initialize
      @pastel = Pastel.new
      @cursor = TTY::Cursor
      @reader = TTY::Reader.new(interrupt: :exit)
      @rows, @cols = TTY::Screen.size

      register_events
    end

    def register_events
      @reader.on(:keypress) do |event|
        if [?\C-x, 'q'].include?(event.value)
          print cursor.clear_screen
          print cursor.move_to(0, 0)
          exit
        end
      end

      input_handler = Thread.new do
        Thread.abort_on_exception = true

        loop do
          @reader.read_keypress
        end
      end

      at_exit do
        print TTY::Cursor.show
        input_handler.kill
      end
    end

    # Start the game
    #
    # @api public
    def run
      print cursor.hide
      puts cursor.clear_screen

      pos = Position[(cols / 3) - 10, rows / 5]
      power_pos = Position[pos.x + 22, pos.y + 10]
      hook_pos = Position[pos.x + 22, pos.y + 13]

      game_frame =TTY::Box.frame(
        left: pos.x - 3, top: pos.y - 2, width: 72, height: 28,
        title: { top_left: " TENPIN BOWLING ", bottom_right: "#{Tenpin::VERSION}" }
      )

      splash_screen = SplashScreen.new(pos.x, pos.y)
      splash_screen.draw
      print game_frame
      @reader.read_keypress
      print cursor.clear_screen

      power_frame = TTY::Box.frame(
        left: power_pos.x, top: power_pos.y, width: 43, height: 3,
        title: { top_left: "WEAK", top_right: "STRONG" })
      hook_frame = TTY::Box.frame(
        left: hook_pos.x, top: hook_pos.y, width: 43, height: 3,
        title: { top_left: "LEFT", top_right: "RIGHT" })

      lane = Lane.new(pos.x, pos.y)
      pins = Pins.new(pos.x, pos.y)
      bowler = Bowler.new(pos.x + 8, pos.y + 23)
      score = Score.new
      scoreboard = Scoreboard.new(pos.x + 23, pos.y - 1, score: score)
      power_bar = SwingBar.new(power_pos.x + 1, power_pos.y + 1,
                               gradient: SwingBar::GRADIENT_POWER)
      hook_bar = SwingBar.new(hook_pos.x + 1, hook_pos.y + 1,
                              gradient: SwingBar::GRADIENT_HOOK)

      loop do
        print game_frame
        lane.draw
        pins.draw
        bowler.draw
        scoreboard.draw
        print power_frame
        print hook_frame

        # set bowler position
        @reader.subscribe(bowler) do
          bowler.wait
        end

        # measure power
        @reader.subscribe(power_bar) do
          power_bar.animate
        end

        # measure hook
        @reader.subscribe(hook_bar) do
          hook_bar.animate
        end

        had_pins = pins.size
        bowler.bowl(pins: pins, power: power_bar.ratio, hook: hook_bar.ratio)
        pins_left = pins.size

        score.roll(had_pins - pins_left) do
          pins.reset
        end

        bowler.reset
        power_bar.reset
        hook_bar.reset

        print cursor.clear_screen
      end

      puts cursor.move_to(rows - 1, 0)
    end
  end # Game
end # Tenpin

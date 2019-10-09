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
require_relative "scoreboard"
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
          puts cursor.clear_screen
          puts cursor.move_to(rows - 1, 0)
          exit
        end
      end

      input_handler = Thread.new do
        Thread.abort_on_exception = true

        loop do
          char = @reader.read_keypress
          if [?\C-x, 'q'].include?(char)
            break
          end
        end
      end

      at_exit do
        print TTY::Cursor.show
        input_handler.kill
        puts "Exiting Tenpin Bowling..."
      end
    end

    # Start the game
    #
    # @api public
    def run
      print cursor.hide
      puts cursor.clear_screen

      pos = Position[(cols / 3) - 10, rows / 5]
      game_frame =TTY::Box.frame(
        left: pos.x - 3, top: pos.y - 2, width: 72, height: 28,
        title: { top_left: " TENPIN BOWLING ", bottom_right: "#{Tenpin::VERSION}" }
      )
      power_frame = TTY::Box.frame(
        left: pos.x + 22, top: pos.y + 18, width: 42, height: 3,
        title: { top_left: "WEAK", top_right: "STRONG" })
      hook_frame = TTY::Box.frame(
        left: pos.x + 22, top: pos.y + 21, width: 42, height: 3,
        title: { top_left: "LEFT", top_right: "RIGHT" })

      lane = Lane.new(pos.x, pos.y)
      pins = Pins.new(pos.x, pos.y)
      bowler = Bowler.new(pos.x + 8, pos.y + 23)
      scoreboard = Scoreboard.new(pos.x + 23, pos.y - 1)
      power_bar = SwingBar.new(pos.x + 23, pos.y + 19,
                               gradient: SwingBar::GRADIENT_POWER)
      hook_bar = SwingBar.new(pos.x + 23, pos.y + 22,
                              gradient: SwingBar::GRADIENT_HOOK)

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

      bowler.bowl

      puts cursor.move_to(rows - 1, 0)
    end
  end # Game
end # Tenpin

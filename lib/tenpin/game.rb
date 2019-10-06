# frozen_string_literal: true

require "pastel"
require "tty-cursor"
require "tty-reader"
require "tty-screen"

require_relative "bowler"
require_relative "lane"
require_relative "pins"
require_relative "position"

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

      lane = Lane.new(pos.x, pos.y)
      pins = Pins.new(pos.x, pos.y)
      bowler = Bowler.new(pos.x + 8, pos.y + 23)
      @reader.subscribe(bowler)

      lane.draw
      pins.draw
      bowler.draw

      bowler.wait

      puts cursor.move_to(rows - 1, 0)
    end
  end # Game
end # Tenpin

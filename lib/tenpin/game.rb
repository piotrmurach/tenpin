# frozen_string_literal: true

require "pastel"
require "tty-cursor"
require "tty-reader"
require "tty-screen"

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
    end

    # Start the game
    #
    # @api public
    def run
      puts cursor.clear_screen

      pos = Position[(cols / 3) - 10, rows / 5]

      lane = Lane.new(pos.x, pos.y)
      pins = Pins.new(pos.x, pos.y)

      lane.draw
      pins.draw

      puts cursor.move_to(rows - 1, 0)
    end
  end # Game
end # Tenpin

# frozen_string_literal: true

require "tty-screen"
require "tty-cursor"

require_relative "tenpin/game"
require_relative "tenpin/version"

module Tenpin
  # The main error
  class Error < StandardError; end

  # Start the game
  #
  # @api public
  def self.run
    game = Tenpin::Game.new
    game.run
  end

  # Print debug information in terminal top right corner
  #
  # @example
  #   prompt.debug "info1", "info2"
  #
  # @param [Array] messages
  #
  # @retrun [nil]
  #
  # @api public
  def self.debug(*messages)
    longest = messages.max_by(&:length).size
    width = TTY::Screen.width - longest
    print TTY::Cursor.save
    messages.each_with_index do |msg, i|
      print TTY::Cursor.move_to(width, i)
      print TTY::Cursor.clear_line_after
      print msg
    end
    print TTY::Cursor.restore
  end
end # Tenpin

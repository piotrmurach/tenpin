# frozen_string_literal: true

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
end # Tenpin

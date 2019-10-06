# frozen_string_literal: true

require_relative "entity"
require_relative "pin"

module Tenpin
  class Pins < Entity
    attr_reader :pins, :collided

    # Initialize all ten pins
    #
    # @param [Integer] dist
    #   the distance between pins
    #
    # @api private
    def initialize(x, y, dist: 4)
      super(x, y)

      @collided = []
      @pins = []
      positions = [
        [3, 0], [3 + dist, 0], [3 + 2*dist, 0], [3 + 3*dist,0],
        [5, 1], [5 + dist, 1], [5 + 2*dist, 1],
        [7,2], [7 + dist,2],
        [9,3]
      ]

      positions.map do |cords|
        @pins << Pin.new(pos.x + cords[0], pos.y + cords[1])
      end
    end

    # Check number of pins in the frame
    #
    # @return [Integer]
    #
    # @api public
    def size
      @pins.size
    end

    # Yield pins
    #
    # @api public
    def each(&block)
      pins.each(&block)
    end

    # Remove a pin from the lane
    #
    # @param [Pin] pin
    #   the pin to remove
    #
    # @api public
    def remove(pin)
      collided << pin if pins.include?(pin)
      pins.delete(pin)
    end

    # Draw all pins on the lane
    #
    # @api public
    def draw
      pins.each(&:draw)
    end
  end # Pins
end # Tenpin

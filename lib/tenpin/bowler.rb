# frozen_string_literal: true

require_relative "entity"
require_relative "position"

module Tenpin
  class Bowler < Entity
    SYMBOL = "O"
    LEFT = Position[-1, 0]
    RIGHT = Position[1, 0]

    # Create a bowler
    def initialize(x, y)
      super(x, y)
      @original = @pos.dup
      @done = false
    end

    def done?
      @done
    end

    # Wait until a roll is done
    #
    # @api public
    def wait
      until @done do
        # waiting ....
      end
    end

    # Draw the current bowler position
    #
    # @api public
    def draw(canvas = $stdout)
      bowler = pastel.blue.on_yellow(SYMBOL)
      canvas.print cursor.move_to(pos.x + 1, pos.y) + bowler
    end

    # Clear current position
    #
    # @api public
    def clear(canvas = $stdout)
      ghost = pastel.on_yellow(" ")
      canvas.print cursor.move_to(pos.x + 1, pos.y) + ghost
    end

    # Move bowler by a vector to a new position
    #
    # @param [Position, Array[Integer]] vector
    #
    # @api public
    def move(vector)
      new_pos = pos + vector

      if new_pos.x >= @original.x - 8 && new_pos.x <= @original.x + 8
        @pos = new_pos
      end
    end

    # Move bowler left
    #
    # @api private
    def keyleft(*)
      return if @done

      clear
      move(LEFT)
      draw
    end

    # Move bowler right
    #
    # @api private
    def keyright(*)
      return if @done

      clear
      move(RIGHT)
      draw
    end

    # Finish bowling
    #
    # @api private
    def keyreturn(*)
      @done = true
    end
    alias keyspace keyreturn
    alias keyenter keyreturn
  end # Bowler
end # Tenpin

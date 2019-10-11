# frozen_string_literal: true

require_relative "entity"
require_relative "position"

module Tenpin
  class Bowler < Entity
    PLAYER = "O"
    BALL = "o"
    LEFT = Position[-1, 0]
    RIGHT = Position[1, 0]

    # Create a bowler
    def initialize(x, y, offset: 23)
      super(x, y)
      @original = @pos.dup
      @offset = offset
      reset
    end

    def reset
      @done = false
    end

    def done?
      @done
    end

    # Bowl a roll
    #
    # @api public
    def bowl(canvas = $stdout, pins: [], delay: 0.1)
      i = 1

      while i <= @offset do
        ball_pos = Position[pos.x + 1, pos.y - i]

        canvas.print cursor.move_to(ball_pos.x, ball_pos.y)

        canvas.print pastel.black.on_yellow(BALL)

        # collision detection
        pins.each do |pin|
          if pin.pos.y == ball_pos.y && pin.pos.x == ball_pos.x

            pin.fall
            pin.clear
            pins.remove(pin)
          end
        end

        sleep(delay) if delay > 0

        # clear ball
        canvas.print cursor.move_to(ball_pos.x, ball_pos.y)
        canvas.print pastel.black.on_yellow(" ")

        i += 1
      end
    end

    # Wait until a roll is done
    #
    # @api public
    def wait
      until @done do
        # waiting ....
        sleep(0.01)
      end
    end

    # Draw the current bowler position
    #
    # @api public
    def draw(canvas = $stdout)
      bowler = pastel.blue.on_yellow(PLAYER)
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

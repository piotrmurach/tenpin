# frozen_string_literal: true

require_relative "entity"
require_relative "position"

module Tenpin
  class Bowler < Entity
    PLAYER = "O"
    BALL = windows? ? "o" : "●"
    GUTTER = "\u2591"
    ARROW = "^"
    LEFT = Position[-1, 0]
    RIGHT = Position[1, 0]

    # Create a bowler
    def initialize(x, y, enable_color: nil, distance: 23, width: 17)
      super(x, y, enable_color: enable_color)
      @original = @pos.dup
      @distance = distance
      @width = width
      reset
    end

    def reset
      @pos = @original.dup
      @done = false
    end

    def done?
      @done
    end

    # Check if ball is outside of the lane
    #
    # @param [Position] pos
    #
    # @return [Boolean]
    def in_gutter?(pos)
      pos.x <= @original.x - @width/2 || pos.x >= @original.x + @width/2
    end

    # Bowl a roll
    #
    # @param [Array[Pin]] pins
    #   the pins in the current frame
    # @param [Integer] power
    #   the power value
    # @param [Integer] hook
    #   the hook value
    #
    # @api public
    def bowl(canvas = $stdout, pins: [], power: nil, hook: nil, delay: 0.1)
      i = 1

      while i <= @distance do
        angle = (hook - 50).abs
        offset = i ** (angle / 25.0) / power.to_f

        if angle < 2
          offset = 0
        elsif angle < 20
          offset *= 0.5
        elsif angle < 40
          offset *= 0.75
        end

        if hook < 51 # bowling left
          offset *= -1
        end

        ball_pos = Position[pos.x + 1 + offset.to_i, pos.y - i]

        canvas.print cursor.move_to(ball_pos.x, ball_pos.y)

        if in_gutter?(ball_pos)
          canvas.print pastel.black.on_yellow(BALL)
          break
        end
        canvas.print pastel.black.on_yellow(BALL)

        # collision detection
        pins.each do |pin|
          if pin.pos.y == ball_pos.y && (pin.pos.x == ball_pos.x ||
              (pin.pos.x - (ball_pos.x + offset.to_i)).abs < 2)

            pins.remove(pin)
            pin.fall
            pin.clear

            power *= 0.75 # reduce power
          end
        end

        sleep(delay) if delay > 0

        # clear ball
        canvas.print cursor.move_to(ball_pos.x, ball_pos.y)
        if in_gutter?(ball_pos)
          canvas.print pastel.black.on_white(GUTTER)
        elsif ball_pos.y == @original.y - 18
          canvas.print pastel.black.on_yellow(ARROW)
        else
          canvas.print pastel.black.on_yellow(" ")
        end

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

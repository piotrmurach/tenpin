# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class SwingBar < Entity
    GRADIENT_PATTERN = "\u2591"

    MAX_WIDTH = 40

    @pastel = Pastel.new

    GRADIENT_POWER = [
      [25, @pastel.black.on_cyan.detach],
      [50, @pastel.black.on_green.detach],
      [75, @pastel.black.on_yellow.detach],
      [100, @pastel.black.on_red.detach]
    ]

    GRADIENT_HOOK = [
      [10, @pastel.black.on_red.detach],
      [25, @pastel.black.on_yellow.detach],
      [40, @pastel.black.on_green.detach],
      [60, @pastel.black.on_cyan.detach],
      [80, @pastel.black.on_green.detach],
      [90, @pastel.black.on_yellow.detach],
      [100, @pastel.black.on_red.detach]
    ]

    attr_reader :width, :time

    attr_accessor :current

    def initialize(x, y, gradient: [], width: MAX_WIDTH)
      super(x, y)
      @time = 0.04
      @width = width
      @gradient = gradient.empty? ? [[100, pastel.black.on_green.detach]] : gradient
      reset
    end

    def reset
      @current = 0
      @direction = 1
      @done = false
    end

    # Current bar ratio
    #
    # @return [Float]
    #
    # @api public
    def ratio
      (current / width.to_f) * 100
    end

    # Draw a current bar step
    #
    # @api public
    def draw(canvas = $stdout)
      if @current > width
        @direction = -1
      elsif @current <= 1
        @direction = 1
      end

      @current += @direction

      if @direction == 1
        color_index = @gradient.find { |grad| ratio <= grad[0] } || @gradient[0]
        canvas.print color_index[1].(GRADIENT_PATTERN)
      else
        canvas.print cursor.backward + " " + cursor.backward
      end
    end

    # Run bar animation
    #
    # @api public
    def animate(canvas = $stdout)
      canvas.print cursor.move_to(pos.x, pos.y)

      until @done
        draw(canvas)
        sleep(time)
      end
    end

    def keyreturn(*)
      @done = true
    end
    alias keyspace keyreturn
    alias keyenter keyreturn

    def keypress(event)
      @done =  ["", "\n", "\r"].include?(event.value)
    end
  end # SwingBar
end # Tenpin

# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class Pin < Entity
    SYMBOL = "\u00a1"

    # Draw a pin at a position
    #
    # @api public
    def draw(canvas = $stdout)
      canvas.print cursor.move_to(pos.x, pos.y)
      canvas.print pastel.bright_white.on_yellow(SYMBOL)
    end

    # Animate falling pin
    #
    # @api public
    def fall(canvas = $stdout)
      canvas.print cursor.move_to(pos.x, pos.y)
      ["-", "\\", "|", "/", "-"].each do |frame|
        canvas.print pastel.bright_white.on_yellow(frame)
        sleep(0.025)
        canvas.print cursor.backward
      end
    end

    # Remove pin from the lane
    #
    # @api public
    def clear(canvas = $stdout)
      canvas.print cursor.move_to(pos.x, pos.y)
      canvas.print pastel.on_yellow(" ")
    end
  end # Pin
end # Tenpin

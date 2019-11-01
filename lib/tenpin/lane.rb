# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class Lane < Entity
    GUTTER = windows? ? "#" : "\u2261"

    # Draw a bowling lane
    #
    # @api public
    def draw(canvas = $stdout)
      width = 17
      gutter = @pastel.black.on_white(GUTTER)

      out = []

      23.times do |i|
        out << cursor.move_to(pos.x, pos.y + i)
        out << gutter
        out << pastel.on_yellow(" " * width)
        out << gutter
      end

      out << cursor.move_to(pos.x, pos.y + 23)
      out << pastel.on_yellow(" " * (width + 2))

      out << cursor.move_to(pos.x + 3, pos.y + 5)
      out << pastel.black.on_yellow("^  ^  ^  ^  ^")
      out << cursor.move_to(pos.x + 9, pos.y + 17)
      out << pastel.black.on_yellow("^")
      out << cursor.move_to(pos.x + 6, pos.y + 18)
      out << pastel.black.on_yellow("^     ^")
      out << cursor.move_to(pos.x + 3, pos.y + 19)
      out << pastel.black.on_yellow("^           ^")

      canvas.print out.join
    end
  end # Lane
end # Tenpin

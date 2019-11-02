# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class InfoBox < Entity
    def draw(*messages, canvas: $stdout)
      messages.each.with_index do |message, i|
        canvas.print cursor.move_to(pos.x, pos.y + i)
        canvas.print message
      end
    end
  end # InfoBox
end # Tenpin

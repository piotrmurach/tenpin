# frozen_string_literal: true

require "pastel"
require "tty-cursor"

require_relative "position"

module Tenpin
  class Entity
    # Check if Windowz
    #
    # @return [Boolean]
    #
    # @api public
    def self.windows?
      ::File::ALT_SEPARATOR == "\\"
    end

    attr_reader :pos, :pastel, :cursor

    def initialize(x, y)
      @pos = Position[x, y]
      @pastel = Pastel.new
      @cursor = TTY::Cursor
    end

    # Equality comparison
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) &&
        other.pos.x == pos.x && other.pos.y == pos.y
    end

    # Equality comparison
    #
    # @api public
    def ==(other)
      other.is_a?(self.class) && 
        other.pos.x == pos.x && other.pos.y == pos.y
    end
  end # Entity
end # Tenpin

# frozen_string_literal: true

module Tenpin
  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def self.[](x, y)
      Position.new(x, y)
    end

    def -(obj)
      case obj
      when self.class
        Position.new(self.x - obj.x, self.y - obj.y)
      when Array
        Position.new(self.x - obj[0], self.y - obj[1])
      else
        raise Tenpin::Error, "Cannot add #{obj.inspect}"
      end
    end

    def +(obj)
      case obj
      when self.class
        Position.new(self.x + obj.x, self.y + obj.y)
      when Array
        Position.new(self.x + obj[0], self.y + obj[1])
      else
        raise Tenpin::Error, "Cannot add #{obj.inspect}"
      end
    end

    # The coordinates
    #
    # @api public
    def to_a
      [x, y]
    end

    # Equality comparison
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) &&
        other.x == x && other.y == y
    end

    # Equality comparison
    #
    # @api public
    def ==(other)
      other.is_a?(self.class) &&
        other.x == x && other.y == y
    end
  end # Position
end # Tenpin

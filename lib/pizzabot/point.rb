# frozen_string_literal: true

module Pizzabot
  class Point
    attr_reader :x, :y

    def initialize(x_cord, y_cord)
      @x = x_cord.to_i
      @y = y_cord.to_i
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def inc_x!
      self.x += 1
    end

    def dec_x!
      self.x -= 1
    end

    def inc_y!
      self.y += 1
    end

    def dec_y!
      self.y -= 1
    end

    def to_s
      "Point##{object_id} x: #{x}, y: #{y}"
    end

    private

    attr_writer :x, :y
  end
end

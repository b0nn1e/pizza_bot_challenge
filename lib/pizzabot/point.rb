# frozen_string_literal: true

module Pizzabot
  class Point
    attr_accessor :x, :y

    def initialize(x_cord, y_cord)
      self.x = x_cord.to_i
      self.y = y_cord.to_i
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def move_right!
      self.x += 1
    end

    def move_left!
      self.x -= 1
    end

    def move_top!
      self.y += 1
    end

    def move_bottom!
      self.y -= 1
    end

    def to_s
      "Point##{object_id} x: #{x}, y: #{y}"
    end
  end
end

module Pizzabot
  class Point
    include Comparable

    attr_accessor :x, :y

    def initialize(x_cord, y_cord)
      self.x = x_cord.to_i
      self.y = y_cord.to_i
    end

    def <=>(other)
      return 1 if distance > other.distance
      return -1 if distance < other.distance

      0
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

    def distance
      Math.sqrt(x**2 + y**2)
    end
  end
end

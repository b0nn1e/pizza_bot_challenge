module Pizzabot
  class Field
    attr_accessor :x, :y

    def initialize(x_size, y_size)
      self.x = x_size.to_i
      self.y = y_size.to_i
    end

    def includes?(point)
      !excludes?(point)
    end

    def excludes?(point)
      point.x > x || point.y > y
    end
  end
end

module Pizzabot
  class Courier
    DROP_ACTION = 'D'.freeze

    MOVE_ACTIONS = {
      top: 'N', # top
      right: 'E', # right
      bottom: 'S', # bottom
      left: 'W' # left
    }.freeze

    MOVE_ACTIONS.keys.each do |key|
      define_method "move_#{key}" do |point|
        return unless send("move_#{key}?", point)

        route.push(MOVE_ACTIONS[key])
        current_point.public_send("move_#{key}!")
        true
      end
    end

    attr_accessor :current_point, :route

    def initialize
      self.route = []
      self.current_point = Point.new(0, 0)
    end

    def drop?(point)
      current_point == point
    end

    def drop!
      route.push(DROP_ACTION)
    end

    def move_forward!(point)
      move_right(point) || move_top(point) || move_left(point) || move_bottom(point)
    end

    private

    def move_right?(point)
      current_point.x < point.x &&
        current_point.y <= point.y
    end

    def move_left?(point)
      current_point.x > point.x &&
        current_point.y > point.y
    end

    def move_top?(point)
      current_point.x == point.x &&
        current_point.y < point.y
    end

    def move_bottom?(point)
      current_point.x == point.x &&
        current_point.y > point.y
    end
  end
end

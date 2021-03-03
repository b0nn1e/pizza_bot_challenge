# frozen_string_literal: true

module Pizzabot
  class Courier
    DROP_ACTION = 'D'

    MOVE_ACTIONS = {
      top: 'N',
      right: 'E',
      bottom: 'S',
      left: 'W'
    }

    MOVE_ACTIONS.keys.each do |key|
      define_method "move_#{key}!" do
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
      move_right! and return if move_right?(point)
      move_left! and return if move_left?(point)
      move_top! and return if move_top?(point)
      move_bottom! and return if move_bottom?(point)

      raise "Route not found. Current_point:#{current_point}, point: #{point}"
    end

    private

    def move_right?(point)
      current_point.x < point.x
    end

    def move_left?(point)
      current_point.x > point.x
    end

    def move_top?(point)
      current_point.y < point.y
    end

    def move_bottom?(point)
      current_point.y > point.y
    end
  end
end

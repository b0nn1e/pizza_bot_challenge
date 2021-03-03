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

    def initialize
      @route = []
      @current_position = Point.new(0, 0)
    end

    def try_to_move!(point)
      try_to_drop!(point) and return false
      try_to_move_right!(point) and return true
      try_to_move_left!(point) and return true
      try_to_move_top!(point) and return true
      try_to_move_bottom!(point) and return true

      raise "Route not found. current_position:#{current_position}, point: #{point}"
    end

    def moved_route
      route.join('')
    end

    private

    attr_reader :current_position, :route

    def try_to_drop!(point)
      return unless current_position == point

      route.push(DROP_ACTION)
    end

    def try_to_move_right!(point)
      return unless current_position.x < point.x

      route.push(MOVE_ACTIONS[:right])
      current_position.inc_x!
    end

    def try_to_move_left!(point)
      return unless current_position.x > point.x

      route.push(MOVE_ACTIONS[:left])
      current_position.dec_x!
    end

    def try_to_move_top!(point)
      return unless current_position.y < point.y

      route.push(MOVE_ACTIONS[:top])
      current_position.inc_y!
    end

    def try_to_move_bottom!(point)
      return unless current_position.y > point.y

      route.push(MOVE_ACTIONS[:bottom])
      current_position.dec_y!
    end
  end
end

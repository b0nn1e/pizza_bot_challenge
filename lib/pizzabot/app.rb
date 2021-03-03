# frozen_string_literal: true

require 'pizzabot/validator'
require 'pizzabot/point'
require 'pizzabot/field'
require 'pizzabot/courier'

module Pizzabot
  class App
    POINTS_REGEX = /\((\d),\s*(\d)\)/
    FIELD_REGEXP = /(\d)\s*x\s*(\d)/

    attr_reader :instructions

    def initialize(instructions)
      @instructions = instructions
    end

    def run
      return validator.error_message if validator.invalid?

      build_route!
      courier.route.join
    end

    private

    attr_writer :instructions

    def build_route!
      loop do
        break if points.empty?

        point = points.shift
        loop do
          courier.drop! and break if courier.drop?(point)

          courier.move_forward!(point)
        end
      end
    end

    def validator
      @validator ||= Validator.new(instructions)
    end

    def points
      @points ||= build_points
    end

    def field
      @field ||= build_field
    end

    def courier
      @courier ||= Courier.new
    end

    def build_field
      size = instructions.scan(FIELD_REGEXP).first
      Field.new(size[0], size[1])
    end

    def build_points
      points = instructions.scan(POINTS_REGEX).map do |match|
        Point.new(match[0], match[1])
      end
      points.reject { |point| field.excludes?(point) }
    end
  end
end

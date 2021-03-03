# frozen_string_literal: true

require 'pizzabot/point'
require 'pizzabot/field'
require 'pizzabot/courier'
require 'pizzabot/errors/validation_error'

module Pizzabot
  class App
    INSTRUCTIONS_REGEXP = /^(\dx\d)\s?(\(\d,\s*\d\)\s*)+\s*$/
    FIELD_REGEXP = /(\d)\s*x\s*(\d)/
    POINTS_REGEX = /\((\d),\s*(\d)\)/

    def initialize(instructions)
      @instructions = instructions
      validate!

      @field = build_field
      @points = build_points
      @courier = Courier.new
    end

    def run
      points.each do |point|
        loop do
          break unless courier.try_to_move!(point)
        end
      end

      courier.moved_route
    end

    private

    attr_reader :instructions, :validator, :points, :field, :courier

    def validate!
      raise ValidationError, 'empty args' if instructions.strip.empty?
      raise ValidationError, 'invalid args' unless INSTRUCTIONS_REGEXP.match?(instructions)
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

require_relative 'validator'
require_relative 'point'
require_relative 'field'
require_relative 'courier'

module Pizzabot
  class App
    POINTS_REGEX = /\((\d),\s*(\d)\)/.freeze
    FILED_REGEXP = /(\d)\s*x\s*(\d)/.freeze

    attr_accessor :input, :output

    def initialize(*args)
      self.input = args.first
      self.output = []
    end

    def run
      return validator.error_message if validator.invalid?

      build_route!
      courier.route.join
    end

    private

    def build_route!
      loop do
        break if points.empty?

        point = points.sort!.shift
        loop do
          if courier.drop?(point)
            courier.drop!
            break
          else
            courier.move_forward!(point)
          end
        end
      end
    end

    def validator
      @validator ||= Validator.new(input)
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
      size = input.scan(FILED_REGEXP).first
      Field.new(size[0], size[1])
    end

    def build_points
      points = input.scan(POINTS_REGEX).map do |match|
        Point.new(match[0], match[1])
      end
      points.reject { |point| field.excludes?(point) }
    end
  end
end

require_relative 'validator'

module Pizzabot
  class App
    attr_accessor :input, :output

    def initialize(*args)
      self.input = args.first
      self.output = ''
    end

    def run
      return validator.error_message if validator.invalid?

    end

    private

    def validator
      @validator ||= Validator.new(input)
    end
  end
end

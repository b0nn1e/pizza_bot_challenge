module Pizzabot
  class Validator
    REGEXP = /^(\dx\d)\s?(\(\d,\s*\d\)\s*)+\s*$/.freeze
    EMPTY_MESSAGE = 'empty args'.freeze
    INVALID_FIELD_SIZE = 'invalid args'.freeze

    attr_accessor :input, :error_message

    def initialize(input = nil)
      self.input = input
    end

    def valid?
      validate_empty! || validate_regexp!

      error_message.nil?
    end

    def invalid?
      !valid?
    end

    private

    def validate_regexp!
      return if REGEXP.match?(input)

      self.error_message = INVALID_FIELD_SIZE
    end

    def validate_empty!
      self.error_message = EMPTY_MESSAGE if input.strip.empty?
    end
  end
end

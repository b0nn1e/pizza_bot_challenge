# frozen_string_literal: true

require 'pizzabot/app'

module Pizzabot
  VERSION = '0.0.1'

  def self.run(args)
    puts App.new(args).run
  end

  def self.version
    VERSION
  end
end

require 'pizzabot/app'

module Pizzabot
  VERSION = '0.0.1'.freeze

  def self.run(args)
    App.new(args).run
  end

  def self.version
    VERSION
  end
end

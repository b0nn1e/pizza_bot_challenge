module Pizzabot
  class App
    attr_accessor :args, :output

    def initialize(*args)
      self.args = args.first
      self.output = ''
    end

    def run
      "it works: #{args}"
    end
  end
end

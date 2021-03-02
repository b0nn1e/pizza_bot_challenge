require_relative 'setup'
require 'pizzabot'

class TestPizzabot < Minitest::Test
  def test_version
    assert_equal(Pizzabot.version, '0.0.1')
  end

  def test_invalid_args
    assert_equal(Pizzabot.run('invalid'), 'invalid args')
  end
end

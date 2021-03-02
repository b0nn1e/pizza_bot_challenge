$:.unshift(File.expand_path('../lib', __dir__))

require 'minitest/autorun'
require 'pizzabot'

class TestPizzabot < Minitest::Test
  def test_version
    assert_equal(Pizzabot.version, '0.0.1')
  end

  def test_running
    assert_equal(Pizzabot.run("test"), "it works: test")
  end
end

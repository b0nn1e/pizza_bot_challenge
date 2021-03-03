require_relative 'setup'
require 'pizzabot'

class TestPizzabot < Minitest::Test
  def test_version
    assert_equal(Pizzabot.version, '0.0.1')
  end

  def test_invalid_args
    assert_equal(Pizzabot.run('invalid'), 'invalid args')
  end

  def test_invalid_empty_args
    assert_equal(Pizzabot.run(' '), 'empty args')
  end

  def test_one_point
    assert_equal(Pizzabot.run('5x5 (1, 3)'), 'ENNND')
  end

  def test_zero_point
    assert_equal(Pizzabot.run('5x5 (0, 0)'), 'D')
  end

  def test_one_point_to_right
    assert_equal(Pizzabot.run('5x5 (1, 0)'), 'ED')
  end

  def test_one_point_to_top
    assert_equal(Pizzabot.run('5x5 (0, 1)'), 'ND')
  end

  def test_correct_points_order
    assert_equal(Pizzabot.run('5x5 (2, 2) (1, 1)'), 'EENNDWSD')
  end

  def test_only_excludes_point
    assert_equal(Pizzabot.run('1x1 (2, 2)'), '')
  end

  def test_with_excludes_point
    assert_equal(Pizzabot.run('5x6 (2, 2) (6, 6)'), 'EENND')
  end

  def test_with_last_points
    assert_equal(Pizzabot.run('2x2 (2, 2)'), 'EENND')
  end

  def test_no_points
    assert_equal(Pizzabot.run('2x2'), 'invalid args')
  end

  def test_with_same_points
    assert_equal(Pizzabot.run('5x5 (1,1)(1,1)'), 'ENDD')
  end

  def test_moving_by_circle
    assert_equal(Pizzabot.run('5x5 (1,1)(1,2)(2,2)(2,1)'), 'ENDNDEDSD')
  end

  def test_example_from_task
    act = 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD'
    exp = '5x5 (0, 0) (1, 3) (4,4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)'
    assert_equal(Pizzabot.run(exp), act)
  end
end

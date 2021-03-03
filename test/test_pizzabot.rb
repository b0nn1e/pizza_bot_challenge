# frozen_string_literal: true

require 'minitest/autorun'
require 'pizzabot'

class TestPizzabot < Minitest::Test
  def assert_equal_output(command, expected_output)
    assert_output("#{expected_output}\n") { Pizzabot.run(command) }
  end

  def test_version
    assert_equal(Pizzabot.version, '0.0.1')
  end

  def test_invalid_args
    assert_equal_output('invalid', 'invalid args')
  end

  def test_empty_args
    assert_equal_output('', 'empty args')
  end

  def test_only_spaces_in_args
    assert_equal_output(' ', 'empty args')
  end

  def test_without_filed_size
    assert_equal_output('(1, 3) (4, 4)', 'invalid args')
  end

  def test_without_points
    assert_equal_output('5x5', 'invalid args')
  end

  def test_without_spaces
    assert_equal_output('5x5(2,2)(1,1)', 'EENNDWSD')
  end

  def test_with_final_space
    assert_equal_output('5x5(2,2)(1,1) ', 'EENNDWSD')
  end

  def test_one_point
    assert_equal_output('5x5 (1, 3)', 'ENNND')
  end

  def test_zero_point
    assert_equal_output('5x5 (0, 0)', 'D')
  end

  def test_one_point_to_right
    assert_equal_output('5x5 (1, 0)', 'ED')
  end

  def test_one_point_to_top
    assert_equal_output('5x5 (0, 1)', 'ND')
  end

  def test_correct_points_order
    assert_equal_output('5x5 (2, 2) (1, 1)', 'EENNDWSD')
  end

  def test_only_excludes_point
    assert_equal_output('1x1 (2, 2)', '')
  end

  def test_with_excludes_point
    assert_equal_output('5x6 (2, 2) (6, 6)', 'EENND')
  end

  def test_with_last_points
    assert_equal_output('2x2 (2, 2)', 'EENND')
  end

  def test_no_points
    assert_equal_output('2x2', 'invalid args')
  end

  def test_with_same_points
    assert_equal_output('5x5 (1,1)(1,1)', 'ENDD')
  end

  def test_moving_by_circle
    assert_equal_output('5x5 (1,1)(1,2)(2,2)(2,1)', 'ENDNDEDSD')
  end

  def test_example_from_task
    assert_equal_output(
      '5x5 (0, 0) (1, 3) (4,4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)',
      'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD'
    )
  end

  def test_running_from_command_line
    output = `./pizzabot "5x5 (0, 0) (1, 3) (4,4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"`
    assert_equal(output, "DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD\n")
  end
end

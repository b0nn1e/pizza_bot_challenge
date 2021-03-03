# frozen_string_literal: true

require 'minitest/autorun'
require 'pizzabot/validator'

class TestValidateArgs < Minitest::Test
  def test_empty
    subject = Pizzabot::Validator.new('')
    assert_equal(subject.valid?, false)
    assert_equal(subject.error_message, 'empty args')
  end

  def test_spasec
    subject = Pizzabot::Validator.new('   ')
    assert_equal(subject.valid?, false)
    assert_equal(subject.error_message, 'empty args')
  end

  def test_invalid
    subject = Pizzabot::Validator.new('invalid args')
    assert_equal(subject.valid?, false)
    assert_equal(subject.error_message, 'invalid args')
  end

  def test_without_filed_size
    subject = Pizzabot::Validator.new('(1, 3) (4, 4) (4, 4)  (4, 4)')
    assert_equal(subject.valid?, false)
    assert_equal(subject.error_message, 'invalid args')
  end

  def test_without_points
    subject = Pizzabot::Validator.new('5x5')
    assert_equal(subject.valid?, false)
    assert_equal(subject.error_message, 'invalid args')
  end

  def test_with_spaces
    subject = Pizzabot::Validator.new('5x5 (1, 3) (4, 4) (4, 4)  (4, 4)')
    assert_equal(subject.valid?, true)
    assert_nil(subject.error_message)
  end

  def test_without_spaces
    subject = Pizzabot::Validator.new('5x5(1,3)(4,4)(4,4)(4,4)')
    assert_equal(subject.valid?, true)
    assert_nil(subject.error_message)
  end
end

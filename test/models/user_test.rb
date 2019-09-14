require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not able to save user without name' do
    user = User.new(date: Date.new, number: 1, description: 'some description')
    assert_not user.save
  end

  test 'should not able to save user without date' do
    user = User.new(name: 'Test Name', number: 1, description: 'some description')
    assert_not user.save
  end

  test 'should not able to save user without number' do
    user = User.new(name: 'Test Name', date: Date.new, description: 'some description')
    assert_not user.save
  end

  test 'should not able to save user without description' do
    user = User.new(name: 'Test Name', date: Date.new, number: 1)
    assert_not user.save
  end

  test 'should able to save valid user' do
    user = User.new(name: 'Test Name', date: Date.new, number: 1, description: 'some description')
    assert user.save
  end
end

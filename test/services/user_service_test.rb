require 'csv'
require 'test_helper'

class UserServiceTest < ActiveSupport::TestCase
  setup do
    @service = UserService.new
  end

  test 'should raise error when dataset is invalid' do
    dataset = CSV.read(file_fixture('invalid_data.csv'), headers: true)
    assert_raises(ActiveModel::UnknownAttributeError) { @service.import_users(dataset) }
  end

  test 'should create user record when dataset is valid' do
    dataset = CSV.read(file_fixture('test.csv'), headers: true)
    assert_difference 'User.count' do
      @service.import_users(dataset)
    end
    assert_equal User.last.name, 'Paul'
    assert_equal User.last.number, 33
    assert_equal User.last.date, Date.parse('1981-08-28')
    assert_equal User.last.description, 'Vivamus id ligula rutrum, this man is the greatest there ever was.'
  end
end

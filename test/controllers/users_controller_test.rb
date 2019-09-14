require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should fallback to home page if file is not csv' do
    fixture_file = fixture_file_upload('files/test.jpeg')
    post import_users_url, params: { file:  fixture_file }
    assert_redirected_to root_url
    assert_equal 'The file is invalid.', flash[:error]
  end

  test 'should fallback to home page if csv file format is invalid' do
    fixture_file = fixture_file_upload('files/invalid_data.csv')
    post import_users_url, params: { file:  fixture_file }
    assert_redirected_to root_url
    assert_equal 'The file is invalid.', flash[:error]
  end

  test 'should create user and redirect to user index page' do
    fixture_file = fixture_file_upload('files/test.csv')
    post import_users_url, params: { file:  fixture_file }
    assert_redirected_to users_url
  end
end

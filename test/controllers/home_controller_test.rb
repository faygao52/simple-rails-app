require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_select 'h1', 'Welcome!'
    assert_select 'label', 'Please select a CSV file'
    assert_response :success
  end

  test 'should able to upload file' do
    get root_url
    assert_response :success

    fixture_file = fixture_file_upload('files/test.csv')
    post import_users_url, params: { file:  fixture_file }
    assert_redirected_to users_url
  end
end

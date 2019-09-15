require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should render search bar' do
    get users_url

    assert_response :success
    assert_select 'h1', 'Data Table'
    assert_select 'input' do 
      assert_select '[placeholder=?]', 'Search by name'
    end
  end

  test 'should render UserList component' do
    get users_url

    assert_response :success

    users = User.all    
    assert_select "span[data-react-class=?]", 'UserList' do |dom|
      if block_given?
        props = JSON.parse(dom.attr("data-react-props"))
        props.deep_symbolize_keys!
        assert_equal users, props[:users]
      end
    end
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

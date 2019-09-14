require 'csv'

# Controller for user page
class UsersController < ApplicationController

  def index
    @users = User.all
    render component: 'UserList', props: { users: @users }, tag: 'span', class: 'todo'
  end

  ##
  # Parse the uploaded file here. Once data imported
  # redirect user to index page, otherwise redirect
  # user back to home page
  def import
    uploaded_file = params[:file]
    begin 
      dataset = CSV.read(uploaded_file.path, headers: true)
      UserService.new.import_users(dataset)
      redirect_to action: 'index'
    rescue
      flash[:error] = 'The file is invalid.'
      redirect_back fallback_location: root_url
    end
  end
end

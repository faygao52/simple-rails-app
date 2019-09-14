require 'csv'

# Controller for user page
class UsersController < ApplicationController
  def index
  end

  ##
  # Import data form csv 
  def import
    uploaded_file = params[:file]
    dataset = CSV.read(uploaded_file.path, headers: true)
    UserService.new.import_users(dataset)
  end
end

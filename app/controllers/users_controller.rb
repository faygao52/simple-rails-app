require 'csv'

# Controller for user page
class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.order(sort_column + " " + sort_direction)
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

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

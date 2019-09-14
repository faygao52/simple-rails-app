##
# User service manages user related operations.
class UserService

  ##
  # Import data from CSV into user records.
  #
  # @param dataset [CSV::table] includes all user rows.
  def import_users(dataset)
    dataset.each do |row|
      user = User.new(row.to_h)
      user.save!
    end
  end
end
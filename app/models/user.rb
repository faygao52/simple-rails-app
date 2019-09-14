##
# User model
class User < ApplicationRecord

    # Validators for user
    validates_presence_of :name, :date, :number, :description
end

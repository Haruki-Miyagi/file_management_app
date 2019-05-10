class UserControllRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
end

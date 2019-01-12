class Room < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :folder
end

class Room < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :folder
  has_many   :documents, dependent: :destroy
  has_many   :messages, dependent: :destroy
end

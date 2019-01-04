class Folder < ApplicationRecord
  validates :name, presence: true

  has_ancestry
  belongs_to :user
end

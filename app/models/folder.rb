class Folder < ApplicationRecord
  validates :name, presence: true

  has_ancestry
  belongs_to :user

  scope :order_by_preference, -> { order(id: :desc) }

  # ルートフォルダを返す
  def self.summit
    find_by(name: 'Root')
  end
end

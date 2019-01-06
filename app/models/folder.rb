class Folder < ApplicationRecord
  validates :name, presence: true

  has_ancestry
  belongs_to :user

  # ルートフォルダを返す
  def self.summit
    find_by(name: 'Root')
  end
end

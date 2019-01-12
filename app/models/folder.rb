class Folder < ApplicationRecord
  validates :name, presence: true

  # [gem 'ancestry'](https://github.com/stefankroes/ancestry)
  #  L フォルダを階層化するため追加(経路列挙(Path Enumeration))
  has_ancestry

  belongs_to :user
  has_many   :room, dependent: :destroy

  scope :order_by_preference, -> { order(id: :desc) }

  # ルートフォルダを返す
  def self.summit
    find_by(name: 'Root', ancestry: nil)
  end
end

class Folder < ApplicationRecord
  validates :name, presence: true

  # [gem 'ancestry'](https://github.com/stefankroes/ancestry)
  #  L フォルダを階層化するため追加(経路列挙(Path Enumeration))
  has_ancestry

  belongs_to :user
  has_many   :room, dependent: :destroy
end

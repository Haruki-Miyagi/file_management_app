class Folder < ApplicationRecord
  validates :name, presence: true

  # [gem 'ancestry'](https://github.com/stefankroes/ancestry)
  #  L フォルダを階層化するため追加(経路列挙(Path Enumeration))
  has_ancestry

  belongs_to :user
  has_many   :rooms, dependent: :destroy

  scope :order_by_preference, -> { order(id: :desc) }
  scope :unset_root, -> { where.not(name: 'Root', ancestry: nil) }

  # ルートフォルダを返す
  def self.summit
    find_by(name: 'Root', ancestry: nil)
  end

  # 子フォルダ全てを取得する(foldersテーブルとroomsテーブルの値を取得)
  # ex) rootフォルダより下のフォルダを取得
  #       L folder01
  #       L folder02
  #       L room01
  def all_childrens
    childrens = []

    children.each do |child|
      childrens << child
    end

    rooms.each do |child|
      childrens << child
    end
    childrens
  end

  # rootから始まりselfで終わるレコードのパス(rootフォルダは含まない)
  def root_below_folder
    path.unset_root
  end
end

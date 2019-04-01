class Document < ApplicationRecord
  mount_uploader :uploaded_file, FileUploader
  validates :uploaded_file, presence: true

  belongs_to :user
  belongs_to :room

  scope :order_by_preference, -> { order(id: :desc) }

  ALLOW_DISPLAY_IMAGE = %w(
    .jpg
    .jpeg
    .png
    .gif
  ).freeze

  # `.jpg, .jpeg, .png, gif` のプレビュー画像を許可する
  def image?
    ALLOW_DISPLAY_IMAGE.include?(File.extname(uploaded_file.url).downcase)
  end
end

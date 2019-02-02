class Document < ApplicationRecord
  mount_uploader :uploaded_file, FileUploader
  validates :uploaded_file, presence: true

  belongs_to :user
  belongs_to :room

  scope :order_by_preference, -> { order(id: :desc) }
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :admin, inclusion: { in: [true, false] }

  has_many :folders,   dependent: :destroy
  has_many :rooms,     dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :user_controll_rooms, dependent: :destroy
  has_many :pending_rooms, through: :user_controll_rooms, source: :room
end

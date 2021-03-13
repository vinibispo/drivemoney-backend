class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  validates :email, presence: true
  has_many :user_tokens
  enum status: [:common, :admin]
end

class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :accounts
  validates :email, presence: true
  has_many :user_tokens
  enum status: [:common, :admin]
end

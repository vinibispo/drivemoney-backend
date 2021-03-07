class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  validates :email, presence: true
end

class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :accounts, dependent: :destroy
  has_many :user_tokens, dependent: :destroy
  validates :email, presence: true
  has_many :user_tokens
  enum status: [:common, :admin]

  def total
    Balances::TotalUser.call(user: self).data[:total_of_accounts]
  end
end

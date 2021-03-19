class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :accounts, dependent: :destroy
  has_many :user_tokens, dependent: :destroy
  validates :email, presence: true
  has_many :user_tokens
  enum status: [:common, :admin]

  def balance
    accounts.inject(0) { |sum, account| sum + account.balance }
  end
end

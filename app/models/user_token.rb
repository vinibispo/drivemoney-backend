class UserToken < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :token, presence: true
end

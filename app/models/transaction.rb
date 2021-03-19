class Transaction < ApplicationRecord
  belongs_to :account
  enum status: [:income, :outcome]
  validates_presence_of :description, :category, :value
end

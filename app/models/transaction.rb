class Transaction < ApplicationRecord
  belongs_to :account
  enum type: [:income, :outcome]
end

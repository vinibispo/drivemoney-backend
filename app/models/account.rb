class Account < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :user
  validates_presence_of :name

  def balance
    (total_income - total_outcome) + initial_value
  end

  def total_income
    transactions.income.sum(:value)
  end

  def total_outcome
    transactions.outcome.sum(:value)
  end
end

class Account < ApplicationRecord
  has_many :transactions
  belongs_to :user

  def total
    Balances::TotalAccount.call(account: self).data[:sum_of_transactions]
  end
end

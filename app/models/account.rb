class Account < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :user
  validates_presence_of :name

  def total
    Balances::TotalAccount.call(account: self).data[:sum_of_transactions]
  end
end

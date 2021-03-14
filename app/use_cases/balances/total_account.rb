module Balances
  class TotalAccount < Micro::Case
    attribute :account
    def call!
      account_total
    end

    private

    def account_total
      sum_of_transactions = account.transactions.inject(account.initial_value) do |sum, num|
        sum + num.value
      end
      Success result: {sum_of_transactions: sum_of_transactions}
    end
  end
end

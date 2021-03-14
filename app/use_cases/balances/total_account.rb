module Balances
  class TotalAccount < Micro::Case
    attribute :account
    def call!
      account_total
    end

    private

    def account_total
      initial_value = account.initial_value
      sum_of_transactions = account
        .transactions
        .sum(:value) + initial_value
      Success result: {sum_of_transactions: sum_of_transactions}
    end
  end
end

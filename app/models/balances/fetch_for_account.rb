module Balances
  class FetchForAccount < Micro::Case
    attribute :account

    def call!
      initial_value = account.initial_value

      balance = (total_income - total_outcome) + initial_value

      Success result: {balance: balance}
    end

    private

    def total_income
      account.transactions.income.sum(:value)
    end

    def total_outcome
      account.transactions.outcome.sum(:value)
    end
  end
end

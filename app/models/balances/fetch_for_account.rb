module Balances
  class FetchForAccount < Micro::Case
    attribute :account

    def call!
      initial_value = account.initial_value

      total_income = account.transactions.total_income
      total_outcome = account.transactions.total_outcome

      balance = (total_income - total_outcome) + initial_value

      Success result: {balance: balance}
    end

    private

  end
end

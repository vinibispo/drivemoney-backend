module Balances
  class FetchForAccount < Micro::Case
    attribute :account
    def call!
      fetch_balance_for_account
    end

    private

    def fetch_balance_for_account
      initial_value = account.initial_value
      balance = account
        .transactions
        .where(status: :income)
        .sum(:value) - account
        .transactions
        .where(status: :outcome)
        .sum(:value) + initial_value
      Success result: {balance: balance}
    end
  end
end

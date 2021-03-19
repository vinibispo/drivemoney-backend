module Balances
  class FetchForAccount < Micro::Case
    attribute :account

    def call!
      balance = account.balance

      Success result: {balance: balance}
    end

  end
end

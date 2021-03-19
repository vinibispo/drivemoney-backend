module Balances
  class FetchForUser < Micro::Case
    attribute :user
    def call!
      balance = user.balance
      Success result: {balance: balance}
    end
  end
end

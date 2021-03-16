module Balances
  class FetchForUser < Micro::Case
    attribute :user
    def call!
      fetch_balance_for_user
    end

    private

    def fetch_balance_for_user
      balance = user.accounts.inject(0) { |sum, account| sum + account.total }
      Success result: {balance: balance}
    end
  end
end

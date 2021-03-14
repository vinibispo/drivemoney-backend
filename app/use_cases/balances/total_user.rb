module Balances
  class TotalUser < Micro::Case
    attribute :user
    def call!
      user_total
    end

    private

    def user_total
      total_of_accounts = user.accounts.inject(0) { |sum, account| sum + account.total }
      Success result: {total_of_accounts: total_of_accounts}
    end
  end
end

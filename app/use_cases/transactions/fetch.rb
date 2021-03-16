module Transactions
  class Fetch < Micro::Case
    flow Accounts::Find,
      call!
    attribute :account
    def call!
      fetch_transactions
    end

    private

    def fetch_transactions
      transactions = account.transactions
      Success result: {transactions: transactions}
    end
  end
end

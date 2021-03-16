module Transactions
  class Find < Micro::Case
    flow Accounts::Find,
      call!
    attribute :transaction_id
    attribute :account
    validates :account, kind: Account
    def call!
      set_transaction
    end

    private

    def set_transaction
      transaction = account.transactions.find_by(id: transaction_id)
      if transaction.present?
        return Success result: {transaction: transaction}
      end
      Failure(:transaction_not_found) { {message: "Transaction not found"} }
    end
  end
end

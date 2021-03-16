module Transactions
  class Update < Micro::Case
    flow Transactions::Find,
      call!

    attribute :account
    attribute :transaction_attributes
    attribute :transaction
    validates :transaction, kind: Transaction
    validates :account, kind: Account
    def call!
      update_transaction
    end

    private

    def update_transaction
      if transaction.update(transaction_attributes)
        return Success result: {transaction: transaction, account: account}
      end
      Failure(:unprocessable_entity) { {errors: transaction.errors} }
    end
  end
end

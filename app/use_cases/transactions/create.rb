module Transactions
  class Create < Micro::Case
    flow Accounts::Find,
      self.call!
    attribute :account
    attribute :transaction_attributes
    validates :account, kind: Account
    def call!
      create_transaction
    end
    private
    def create_transaction
      transaction = account.transactions.new(transaction_attributes)
      if transaction.save
        return Success result: {transaction: transaction, account: account}
      end
      Failure(:unprocessable_entity) { {errors: transaction.errors} }
    end
  end
end

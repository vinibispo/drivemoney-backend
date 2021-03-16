module Transactions
  class Update < Micro::Case
    flow Transactions::Find,
      self.call!

    attribute :transaction_attributes
    attribute :transaction
    validates :transaction, kind: Transaction
    def call!
      update_transaction
    end

    private
    def update_transaction
      if transaction.update(transaction_attributes)
        return Success result: {transaction: transaction}
      end
      Failure(:unprocessable_entity) { { errors: transaction.errors } }
    end
  end
end

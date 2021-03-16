module Transactions
  class Destroy < Micro::Case
    flow Transactions::Find,
      call!
    attribute :transaction
    validates :transaction, kind: Transaction
    def call!
      destroy_transaction
    end

    private

    def destroy_transaction
      transaction.destroy if transaction.valid?
      Success { attributes }
    end
  end
end

module Accounts
  class Create < Micro::Case
    attribute :user
    attribute :account_attributes

    def call!
      create_account
    end

    private

    def create_account
      account = user.accounts.new(account_attributes)
      if account.save
        return Success result: {account: account}
      end
      Failure(:unprocessable_entity) { {errors: account.errors} }
    end
  end
end

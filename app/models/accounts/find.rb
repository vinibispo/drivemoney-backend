module Accounts
  class Find < Micro::Case
    attribute :user
    attribute :id
    def call!
      find_account
    end

    private

    def find_account
      account = user.accounts.find_by(id: id)
      if account.present?
        return Success result: {account: account}
      end
      Failure(:not_found) { {message: "Account not found"} }
    end
  end
end

module Accounts
  class Find < Micro::Case
    attribute :user
    attribute :id
    def call!
      verify_id
        .then(method(:find_account))
    end

    private

    def verify_id
      if id.present?
        return Success result: {id: id}
      end
      Failure(:not_found) { {message: "Account not found"} }
    end

    def find_account(id:, **)
      account = user.accounts.find_by(id: id)
      if account.present?
        return Success result: {account: account}
      end
      Failure(:not_found) { {message: "Account not found"} }
    end
  end
end

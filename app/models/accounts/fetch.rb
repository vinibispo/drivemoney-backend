module Accounts
  class Fetch < Micro::Case
    attribute :user
    validates :user, kind: User
    def call!
      accounts = user.accounts
      Success result: {accounts: accounts}
    end
  end
end

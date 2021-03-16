module Accounts
  class Update < Micro::Case
    flow Accounts::Find,
      self.call!
    attribute :account
    attribute :account_attributes

    validates :account, kind: Account

    def call!
      update_account
    end

    private
     def update_account
       if account.update(account_attributes)
         return Success result: { account: account }
       end
       Failure(:unprocessable_entity) { { errors: account.errors } }
     end
  end
end

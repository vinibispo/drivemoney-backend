module Accounts
  class Destroy < Micro::Case
    flow Accounts::Find,
      self.call!
    attribute :account
    validates :account, kind: Account

    def call!
      account.destroy if account.valid?
      Success result: attributes
    end
  end
end

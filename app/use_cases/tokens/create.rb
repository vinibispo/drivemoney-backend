module Tokens
  class Create < Micro::Case
    attribute :user
    def call!
      Success result: {token: JWT.encode({user_id: user.id}, "s3cr3t")}
    end
  end
end

module Tokens
  class Create < Micro::Case
    attribute :user
    def call!
      Success result: {token: JWT.encode({user_id: user.id}, Figaro.env.secret_jwt_key)}
    end
  end
end

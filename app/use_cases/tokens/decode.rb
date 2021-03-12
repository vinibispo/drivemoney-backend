module Tokens
  class Decode < Micro::Case
    attribute :token
    def call!
      result, _ = JWT.decode(token, "s3cr3t", true)
      Success result: result
    rescue JWT::DecodeError => error
      Failure(:invalid_token, result: {error: error.message})
    end
  end
end

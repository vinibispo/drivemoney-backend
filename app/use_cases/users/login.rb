require "uri"
module Users
  class Login < Micro::Case
    attribute :email
    attribute :password, default: ->(value) { value.to_s.strip }

    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true

    def call!
      valid_params
        .then(method(:find_user_by_email))
        .then(method(:authenticate_password))
        .then(Tokens::Create)
        .then(method(:serialize_user))
    end

    private

    def valid_params
      Success result: attributes(:email, :password)
    end

    def find_user_by_email(email:, **)
      user = User.find_by(email: email)
      return Failure(:user_not_found) if user.blank?
      Success result: {user: user}
    end

    def authenticate_password(user:, **)
      return Success result: {user: user} if user.authenticate(password)
      Failure(:unauthorized)
    end

    def serialize_user(user:, token:, **)
      user_as_json = user.as_json(only: [:id, :first_name, :last_name, :email])
      Success result: {user: user_as_json.merge({"total": user.total}), token: token}
    end
  end
end

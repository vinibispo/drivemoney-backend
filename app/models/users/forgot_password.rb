module Users
  class ForgotPassword < Micro::Case
    attribute :email
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
    def call!
      valid_params
        .then(method(:find_user_by_email))
        .then(method(:generate_token))
        .then(method(:create_user_token))
        .then(method(:send_forgot_mail))
    end

    private

    def valid_params
      Success result: attributes(:email)
    end

    def find_user_by_email
      user = User.find_by(email: email)
      return Failure(:user_not_found) unless user.present?
      Success result: {user: user}
    end

    def generate_token
      token = SecureRandom.uuid
      Success result: {token: token}
    end

    def create_user_token(user:, token:, **)
      token = UserToken.create(user: user, token: token)
      Success result: {token: token, user: user}
    end

    def send_forgot_mail(user:, token:, **)
      UserMailer.forgot_password(id: user.id, token: token.token).deliver_now
      Success result: {user: user}
    end
  end
end

module Users
  class ResetPassword < Micro::Case
    attribute :token
    attribute :password
    attribute :password_confirmation
    def call!
      find_user_token
        .then(method(:is_in_time_for_reset_password?))
        .then(method(:validate_password_params))
        .then(method(:update_password_params))
    end

    private

    def is_in_time_for_reset_password?(user_token:, **)
      time_for_reset_password = user_token.created_at + 1.day
      return Failure(:date_expired) if Time.now > time_for_reset_password
      Success result: {user: user_token.user}
    end

    def find_user_token
      user_token = UserToken.last
      return Failure(:not_found) unless user_token.token == token
      Success result: {user_token: user_token}
    end

    def validate_password_params
      password_validation = User::Password.new(password, password_confirmation)
      return Success result: attributes unless password_validation.errors?
      Failure(:invalid_params) { {errors: password_validation.errors} }
    end

    def update_password_params(user:, **)
      if user.update(password: password)
        Success result: {user: user}
      end
    end
  end
end

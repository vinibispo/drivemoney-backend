# RegisterUser is responsible for registering a user
module Users
  class Register < Micro::Case
    attribute :first_name
    attribute :email
    attribute :last_name
    attribute :password, default: ->(value) { value.to_s.strip }
    attribute :password_confirmation, default: ->(value) { value.to_s.strip }

    def call!
      transaction {
        validate_password_params
          .then(method(:compare_passwords))
          .then(method(:create_user))
      }.then(method(:send_mail_welcome))
        .then(Tokens::Create)
        .then(method(:serialize_user))
    end

    private

    def validate_password_params
      errors = {}
      errors[:password] = ["can't be blank"] if password.blank?
      errors[:password_confirmation] = ["can't be blank"] if password_confirmation.blank?
      return Success(:valid_params, result: {password: password, password_confirmation: password_confirmation}) if errors.blank?
      Failure(:invalid_params, result: {errors: errors})
    end

    def compare_passwords(password:, password_confirmation:, **)
      return Success() if password == password_confirmation
      error_data = {user: {password_confirmation: ["doesn't match password"]}}
      Failure(:wrong_passwords, result: error_data)
    end

    def create_user(**user_data)
      first_name, last_name, email, password = user_data.values_at(:first_name, :last_name, :email, :password)
      user = User.new(first_name: first_name, last_name: last_name, email: email, password: password)
      if user.save
        Success result: {user: user}
      else
        Failure(:invalid_user, result: {user: user.errors.as_json})
      end
    end

    def serialize_user(user:, token:, **)
      user_as_json = user.as_json(only: [:id, :first_name, :last_name, :email])
      Success result: {user: user_as_json, token: token}
    end

    def send_mail_welcome(user:, **)
      UserMailer.with(user: user).welcome.deliver_later
      Success(:welcome_email_was_sent)
    end
  end
end

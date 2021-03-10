class CreateUser < Micro::Case
  attribute :params
  def call!
    user_params = params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
    password = user_params[:password].to_s.strip
    password_confirmation = user_params[:password_confirmation].to_s.strip
    errors = {}
    errors[:password] = ["can't be blank"] if password.blank?
    errors[:password_confirmation] = ["can't be blank"] if password_confirmation.blank?
    if errors.present?
      Failure(:invalid_params, result: {errors: errors})
    elsif password != password_confirmation
      error_data = {user: {password_confirmation: ["doesn't match password"]}}
      Failure(:wrong_passwords, result: error_data)
    else
      user = User.new(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], password: password)
      if user.save
        user_as_json = user.as_json(only: [:id, :first_name, :last_name, :email])
        Success result: {user: user_as_json}
      else
        Failure(:invalid_user, result: {user: user.errors.as_json})
      end
    end
  rescue ActionController::ParameterMissing => exception
    Failure(:parameter_missing, result: {message: exception.message})
  end
end

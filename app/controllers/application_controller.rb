class ApplicationController < ActionController::API
  before_action :authorized

  protected

  def encode_token(payload)
    JWT.encode(payload, "s3cr3t")
  end

  def authorized
    render json: {message: "Please log in"}, status: :unauthorized unless logged_in?
  end

  private

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, "s3cr3t", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def render_json(status, json = {})
    render status: status, json: json
  end

  def show_parameter_missing_error(exception)
    render_json(400, error: exception.message)
  end
end

class ApplicationController < ActionController::API
  before_action :authorized

  protected

  def authorized
    render_json(:unauthorized, {message: "Please log in"})
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      Tokens::Decode.call(token: token)
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      result = Users::Find.call(user_id: user_id)
      @user = result.data[:user]
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

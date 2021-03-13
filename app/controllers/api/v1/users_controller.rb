module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def create
        Users::Register
          .call(user_params.to_h) do |on|
            on.success { |result| render_user_json(:created, result[:user]) }
            on.failure(:invalid_params) { |data| render_unprocessable_entity(data[:errors]) }
            on.failure(:wrong_passwords) { |data| render_unprocessable_entity(data[:user]) }
            on.failure(:invalid_user) { |data| render_unprocessable_entity(data[:user]) }
          end
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def login
        Users::Login
          .call(login_params.to_h) do |on|
            on.success { |result| render_json(:ok, {user: result[:user], token: result[:token]}) }
            on.failure(:user_not_found) { |data| render_json(:unauthorized, {error: "User not found"}) }
            on.failure(:unauthorized) { |data| render_json(:unauthorized, {error: "User not found"}) }
          end
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def auto_login
        render json: @user
      end

      def forgot_password
        email = user_params[:email]
        Users::ForgotPassword
          .call(email: email) do |on|
            on.success { |result| render_user_json(:ok, result.data[:user]) }
            on.failure(:user_not_found) { |result| render_user_json(:not_found, {errors: ["User not found"]}) }
          end
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def reset_password
        Users::ResetPassword
          .call(user_params.to_h) do |on|
            on.success { |result| render_json(:accepted, {message: "Password updated successfully"}) }
            on.failure(:not_found) { |result| render_json(:not_found, {message: "User not found"}) }
            on.failure(:date_expired) { |result| render_json(:gone, {message: "Time expired"}) }
            on.failure(:invalid_params) { |result| render_json(:bad_request, {message: "Password does not match"}) }
          end
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :token)
      end

      def login_params
        if params[:email].present? && params[:password].present?
          params.permit(:email, :password)
        else
          raise ActionController::ParameterMissing, "email and password must be provided"
        end
      end

      private

      def render_user_json(status, json)
        render_json(status, user: json)
      end

      def render_unprocessable_entity(json)
        render_user_json(:unprocessable_entity, json)
      end
    end
  end
end

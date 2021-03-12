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
            on.success { |result|  render_user_json(:ok, result[:user]) }
            on.failure(:user_not_found)  { |data| render_json(:unauthorized, {error: "User not found"}) }
            on.failure(:unauthorized) { |data| render_json(:unauthorized, {error: "User not found"}) }
          end
      end

      def auto_login
        render json: @user
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
      end

      def login_params
        params.permit(:email, :password)
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

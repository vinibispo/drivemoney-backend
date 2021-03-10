module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def create
        RegistrationUser
          .call(user_params.to_h)
          .on_success { |result| render_user_json(:created, result[:user]) }
          .on_failure(:invalid_params) { |data| render_unprocessable_entity(data[:errors]) }
          .on_failure(:wrong_passwords) { |data| render_unprocessable_entity(data[:user]) }
          .on_failure(:invalid_user) { |data| render_unprocessable_entity(data[:user]) }
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}, status: :ok
        else
          render json: {error: "Invalid username or password"}, status: :unauthorized
        end
      end

      def auto_login
        render json: @user
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
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

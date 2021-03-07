module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def create
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
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
        params.require(:user).permit(:first_name, :last_name, :password)
      end
    end
  end
end

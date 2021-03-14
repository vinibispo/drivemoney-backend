module Api
  module V1
    class AccountsController < ApplicationController
      before_action :authorized
      before_action :set_account, only: [:update, :show, :destroy]
      def index
        @accounts = @user.accounts
      end

      def create
        account = @user.accounts.new(account_params)
        if account.save
          @account = account
          render :show, status: :created, location: api_v1_account_path(@account)
        else
          render json: account.errors, status: :unprocessable_entity
        end
      end

      def update
        if @account.update(account_params)
          render json: {account: @account}
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @account.destroy
      end

      def show
      end

      private

      def account_params
        params
          .require(:account)
          .permit(:name, :initial_value, :active)
      end

      def set_account
        @account = @user.accounts.find_by(id: params[:id])
        if @account.present?
          return @account
        end
        render_json(:not_found, {message: "Account not found"})
      end
    end
  end
end

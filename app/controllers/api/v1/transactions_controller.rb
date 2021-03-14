module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :authorized
      before_action :set_account
      before_action :set_transaction, only: [:show, :update, :destroy]
      def index
        @transactions = @account.transactions
      end

      def create
        @transaction = @account.transactions.new(transaction_params)
        if @transaction.save
          render :show, status: :created, location: api_v1_account_transactions_path(@account.id, @transaction)
        else
          render_json(:unprocessable_entity, {errors: @transaction.errors})
        end
      end

      def show
      end

      def update
        if @transaction.update(transaction_params)
          render :show, status: :ok, location: api_v1_account_transactions_path(@account.id, @transaction)
        else
          render_json(:unprocessable_entity, @account.errors)
        end
      end

      def destroy
        @transaction.destroy
      end

      private

      def set_account
        @account = @user.accounts.find_by(id: params[:account_id])
        if @account.present?
          @account
        else
          render_json(:not_found, {message: "Account not found"})
        end
      end

      def transaction_params
        params
          .require(:transaction)
          .permit(:description, :category, :value, :status)
      end

      def set_transaction
        @transaction = @account.transactions.find_by(id: params[:id])
        if @transaction.present?
          @transaction
        else
          render_json(:not_found, {message: "Transaction not found"})
        end
      end
    end
  end
end

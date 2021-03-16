module Api
  module V1
    class TransactionsController < Api::V1::BaseController
      def index
        Transactions::Fetch
          .call(id: params[:account_id], user: @user)
          .on_success { |result| @transactions = result[:transactions] }
          .on_failure(:not_found) { |result| render_json(:not_found, {message: result[:message]}) }
      end

      def create
        Transactions::Create
          .call(user: @user, id: params[:account_id], transaction_attributes: transaction_params)
          .on_success { |result| render_transaction_show(result[:transaction], result[:account]) }
          .on_failure(:unprocessable_entity) { |result| render_json(:unprocessable_entity, {errors: result[:errors]}) }
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def show
        Transactions::Find
          .call(id: params[:account_id], user: @user, transaction_id: params[:id])
          .on_success { |result| @transaction = result[:transaction] }
          .on_failure(:not_found) { |result| render_json(:not_found, {message: result[:message]}) }
          .on_failure(:transaction_not_found) { |result| render_json(:not_found, {message: result[:message]}) }
      end

      def update
        Transactions::Update
          .call(id: params[:account_id], user: @user, transaction_id: params[:id], transaction_attributes: transaction_params)
          .on_success { |result| render_json(:ok, {transaction: result[:transaction]}) }
          .on_failure(:not_found) { |result| render_json(:not_found, {message: result[:message]}) }
          .on_failure(:transaction_not_found) { |result| render_json(:not_found, {message: result[:message]}) }
          .on_failure(:unprocessable_entity) { |result| render_json(:unprocessable_entity, {errors: result[:errors]}) }
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def destroy
        Transactions::Destroy
          .call(user: @user, id: params[:account_id], transaction_id: params[:id])
          .on_failure(:not_found) { |result| render_json(:not_found, {message: result[:message]}) }
          .on_failure(:transaction_not_found) { |result| render_json(:not_found, {message: result[:message]}) }
      end

      private

      def transaction_params
        params
          .require(:transaction)
          .permit(:description, :category, :value, :status)
      end

      def render_transaction_show(transaction, account, status = :created)
        @transaction = transaction
        render :show, status: status, location: api_v1_account_transactions_path(account.id, @transaction)
      end
    end
  end
end

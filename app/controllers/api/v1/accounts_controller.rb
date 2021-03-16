module Api
  module V1
    class AccountsController < Api::V1::BaseController
      def index
        Accounts::Fetch
          .call(user: @user)
          .on_success { |result| @accounts = result[:accounts] }
      end

      def create
        Accounts::Create
          .call(user: @user, account_attributes: account_params)
          .on_success { |result| render_account_show(result[:account]) }
          .on_failure(:unprocessable_entity) { |result| render json: result[:errors], status: :unprocessable_entity }
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def update
        Accounts::Update
          .call(user: @user, id: params[:id], account_attributes: account_params)
          .on_failure(:not_found) { |result| render_json(:not_found, {message: "Account not found"}) }
          .on_failure(:unprocessable_entity) { |result| render_json(:unprocessable_entity, {errors: result[:errors]}) }
          .on_success { |result| render_json(:ok, {account: result[:account]}) }
      rescue ActionController::ParameterMissing => exception
        render_json(:bad_request, error: exception.message)
      end

      def destroy
        Accounts::Destroy
          .call(user: @user, id: params[:id])
          .on_failure(:not_found) { |result| render_json(:not_found, {message: "Account not found"}) }
      end

      def show
        Accounts::Find.call(id: params[:id], user: @user) do |on|
          on.failure(:not_found) { |result| render_json(:not_found, {message: "Account not found"}) }
          on.success { |result| @account = result[:account] }
        end
      end

      private

      def account_params
        params
          .require(:account)
          .permit(:name, :initial_value, :active)
      end

      def render_account_show(account, status = :created)
        @account = account
        render :show, status: status, location: api_v1_account_path(@account)
      end
    end
  end
end

class AccountsController < ApplicationController
  before_action :authorized
  before_action :set_account, only: [:update, :show]
  def index
    @user.accounts
  end

  def create
    account = @user.accounts.new(account_params)
    if account.save
      render json: {account: account}
    else
      render json: account.errors
    end
  end

  def update
    if @account.update(account_params)
      render json: {account: @account}
    else
      render json: @account.errors
    end
  end

  private

  def account_params
    params
      .require(:account)
      .permit(:name, initial_value: 0, active: true)
  end

  def set_account
    @account = @user.account.find_by(id: params[:account_id])
  end
end

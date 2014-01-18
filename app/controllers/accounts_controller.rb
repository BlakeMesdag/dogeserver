class AccountsController < ApplicationController
  respond_to :json

  before_filter :load_account

  def show
    respond_with @account
  end

  def create
    @account = Account.create(account_params)

    respond_with @account
  end

  private

  def account_params
    params.require(:account).permit(:name, :key)
  end

  def load_account
    @account = Account.find_by(name: params[:name], key: params[:key])
  end

end

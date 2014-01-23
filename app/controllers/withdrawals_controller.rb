class WithdrawalsController < ApplicationController
  before_filter :load_account, only: :create

  def create
    @account.withdrawals.create(withdrawal_params)
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:to)
  end

  def load_account
    @account = Account.find_by(name: params[:account_name], key: params[:key])
  end
end

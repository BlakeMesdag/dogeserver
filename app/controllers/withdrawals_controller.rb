class WithdrawalsController < ApplicationController
  respond_to :json

  before_filter :load_account, only: :create

  def create
    withdrawal = @account.withdrawals.create(withdrawal_params)

    respond_with withdrawal, location: nil
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:to, :amount)
  end

  def load_account
    @account = Account.find_by(name: params[:account_name], key: params[:key])
  end
end

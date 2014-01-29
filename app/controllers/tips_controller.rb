class TipsController < ApplicationController
  respond_to :json

  def create
    from = Account.find_by(name: params[:account_name], key: params[:key])
    to   = Account.find_by(name: tip_params[:to])

    @tip = Tip.create(from: from, to: to, amount: tip_params[:amount])

    respond_with @tip, location: nil
  end

  private

  def tip_params
    params.require(:tip).permit(:to, :amount)
  end

end

class TipsController < ApplicationController
  respond_to :json

  def create
    from = Account.where(name: params[:account_name].to_s, key: params[:key].to_s).first!
    to   = Account.where(name: tip_params[:to].to_s).first!

    @tip = from.pending_tips.create(to: to, amount: tip_params[:amount].to_s)

    respond_with @tip, location: nil
  end

  private

  def tip_params
    params.require(:tip).permit(:to, :amount)
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render status: 404, text: "Not found"}
      format.json { render status: 404, json: {errors: "not found"}}
    end
  end

end

class TipSerializer < ActiveModel::Serializer
  attributes :from, :to, :amount
end

class TipsController < ApplicationController
  respond_to :json

  def create
    from = Account.find_by(name: from_params[:name], key: from_params[:key])
    to   = Account.find_by(name: to_params[:name])

    @tip = Tip.create(from, to, amount_params)

    respond_with @tip, serializer: TipSerializer, location: nil
  end

  private

  def amount_params
    params.require(:amount)
  end

  def from_params
    params.require(:from).permit(:name, :key)
  end

  def to_params
    params.require(:to).permit(:name)
  end

end

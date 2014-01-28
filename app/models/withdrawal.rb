class Withdrawal < ActiveRecord::Base
  belongs_to :account

  after_create :perform

  validates :account_id, :to, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 5 }
  validates :to, length: { is: 34 }

  def perform
    confirmation = DogeAPI.withdraw(to, amount)

    if valid_confirmation?(confirmation)
      update_attributes(confirmation: confirmation)
      account.transactions.create!(amount: amount * -1)
    else
      raise DogeAPI::UnexpectedResponse.new("Withdraw request returned unexpected response: #{confirmation}")
    end
  end

  private

  def valid_confirmation?(confirmation)
    confirmation.present? && confirmation.length == 64
  end
end

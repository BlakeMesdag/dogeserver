class Withdrawal < ActiveRecord::Base
  belongs_to :account

  validates :account_id, :to, :amount, presence: true
  validates :amount, length: { is: 34 }

  before_create :perform

  private

  def perform
    DogAPI.withdraw(to, amount)
  end
end

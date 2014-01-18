class Transaction < ActiveRecord::Base
  belongs_to :account

  before_validation :zero_amount

  validates :amount, presence: true
  validate :positive_balance

  private

  def zero_amount
    self.amount ||= 0
  end

  def positive_balance
    if (account.balance + amount) < 0
      self.errors.add(:amount, "is greater than current balance")
    end
  end
end

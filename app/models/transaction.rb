class Transaction < ActiveRecord::Base
  belongs_to :account

  validates :amount, presence: true
  validate :positive_balance

  private

  def positive_balance
    if (account.balance + amount) < 0
      self.errors.add(:amount, "is greater than current balance")
    end
  end
end

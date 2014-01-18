class Transaction < ActiveRecord::Base
  belongs_to :account

  validates :amount, presence: true
  validate :positive_amount

  private

  def positive_amount
    self.errors.add(:amount, "is greater than current balance")
  end
end

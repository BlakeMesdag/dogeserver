class Tip < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'

  validate :sender_has_enough_funds
  validates :to_id, :from_id, :amount, presence: true
  after_create :create_transactions

  def serializable_hash(options = {})
    super options.merge({ except: [:id, :to_id, :from_id], methods: [:to_name, :from_name] })
  end

  def to_name
    to.name
  end

  def from_name
    from.name
  end

  def create_transactions
    ActiveRecord::Base.transaction do
      from.transactions.create!(amount: amount * -1)
      to.transactions.create!(amount: amount)
    end
  end

  private

  def sender_has_enough_funds
    return unless from.try(:balance) && amount

    errors.add(:amount, "is greater than sender's balance") if from.balance < amount
  end
end

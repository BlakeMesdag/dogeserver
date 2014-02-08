class PendingTip < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'

  validates :to, :from, :amount, presence: true
  validates :amount, numericality: {greater_than: 0}

  before_create :validates_amount_less_than_balance

  def serializable_hash(options = {})
    super options.merge({ except: [:id, :to_id, :from_id, :created_at, :updated_at], methods: [:to_name, :from_name] })
  end

  def to_name
    to.name
  end

  def from_name
    from.name
  end

  def validates_amount_less_than_balance
    errors.add(:amount, "is greater than account balance") if amount > from.balance
  end
end

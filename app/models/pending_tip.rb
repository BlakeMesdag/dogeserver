class PendingTip < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'

  validates :to, :from, :amount, presence: true
  validates :amount, numericality: {greater_than: 0}

  def serializable_hash(options = {})
    super options.merge({ except: [:id, :to_id, :from_id, :created_at, :updated_at], methods: [:to_name, :from_name] })
  end

  def to_name
    to.name
  end

  def from_name
    from.name
  end
end

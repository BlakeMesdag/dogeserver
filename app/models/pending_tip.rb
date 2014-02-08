class PendingTip < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'

  validates :to, :from, :amount, presence: true
  validates :amount, numericality: {greater_than: 0}
end

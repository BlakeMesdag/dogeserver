class Account < ActiveRecord::Base
  has_many :transactions

  validates :name, :key, presence: true
  validates :name, uniqueness: true

  def balance
    transactions.sum(:amount)
  end
end

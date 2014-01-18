class Account < ActiveRecord::Base
  has_many :transactions

  validates :name, :key, presence: true
  validates :name, uniqueness: true

  def balance
    transactions.sum(:amount)
  end

  def serializable_hash(options)
    new_options = (options || {}).merge(except: [:id, :key, :updated_at, :created_at])
    super new_options
  end
end

class Account < ActiveRecord::Base
  include Redis::Objects

  value :deposited

  has_many :transactions

  before_validation :set_deposit_address

  validates :name, :key, :deposit_address, presence: true
  validates :name, uniqueness: true

  def self.fetch_deposits
    find_each do |a|
      if a.remote_deposits_sum > a.local_deposits_sum
        a.transactions.create!(amount: a.remote_deposits_sum - a.local_deposits_sum)
        a.deposited = a.remote_deposits_sum
      end
    end
  end

  def balance
    transactions.sum(:amount)
  end

  def serializable_hash(options)
    new_options = (options || {}).merge(except: [:id, :key, :updated_at, :created_at, :deposit_address])
    super new_options
  end

  def remote_deposits_sum
    @remote_deposits_sum ||= DogeAPI.get_address_received(deposit_address)
  end

  def local_deposits_sum
    @local_deposits_sum ||= deposited.to_f
  end

  private

  def set_deposit_address
    self.deposit_address = DogeAPI.get_new_address(name)
  end
end

class Account < ActiveRecord::Base
  include Redis::Objects

  value :deposited

  has_many :transactions

  before_validation :set_deposit_address

  validates :name, :key, :deposit_address, presence: true
  validates :name, uniqueness: true

  def self.fetch_deposits
    accounts = Account.where(deposit_address: DogeAPI.get_my_addresses)
    accounts.find_each do |account|
      current_deposit_total  = DogeAPI.get_address_received(account.deposit_address)
      previous_deposit_total = account.deposited

      if current_deposit_total > previous_deposit_total
        account.transactions.create!(amount: current_deposit_total - previous_deposit_total)
        account.deposited = current_deposit_total
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

  private

  def set_deposit_address
    self.deposit_address = DogeAPI.get_new_address(name)
  end
end

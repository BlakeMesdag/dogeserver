class Account < ActiveRecord::Base
  has_many :transactions, dependent: :nullify
  has_many :withdrawals, dependent: :nullify
  has_many :received_tips, class_name: 'Tip', foreign_key: 'to_id', dependent: :nullify
  has_many :sent_tips, class_name: 'Tip', foreign_key: 'from_id', dependent: :nullify

  before_validation :set_deposit_address

  validates :name, :key, :deposit_address, :deposited, presence: true
  validates :name, uniqueness: true
  validates :deposit_address, length: { is: 34 }

  def self.fetch_deposits
    find_each do |a|
      if a.remote_deposits_sum > a.deposited
        a.transactions.create!(amount: a.remote_deposits_sum - a.deposited)
        a.update_attributes(deposited: a.remote_deposits_sum)
      end
    end
  end

  def balance
    transactions.sum(:amount)
  end

  def serializable_hash(options = {})
    super options.merge(except: [:id, :key, :updated_at, :created_at, :deposit_address])
  end

  def remote_deposits_sum
    @remote_deposits_sum ||= DogeAPI.get_address_received(deposit_address)
  end

  private

  def set_deposit_address
    puts "SETTING DEPOSIT ADDRESS"
    r = DogeAPI.get_new_address(name)
    puts r
    self.deposit_address ||= r
  end
end

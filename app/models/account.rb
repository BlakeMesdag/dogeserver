class Account < ActiveRecord::Base
  include Redis::Objects

  value :deposited

  has_many :transactions

  before_validation :set_deposit_address

  validates :name, :key, :deposit_address, presence: true
  validates :name, uniqueness: true

  DOGEAPI_BASE_URI = "https://www.dogeapi.com/wow/?api_key=#{Settings::KEYS['DOGEAPI_API_KEY']}&"

  def self.fetch_deposits
    accounts = Account.where(deposit_address: get_my_addresses)
    accounts.find_each do |account|
      current_deposit_total  = get_address_received(account.deposit_address).to_i
      previous_deposit_total = account.deposited.to_i

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
    self.deposit_address = get_new_address(name)
  end

  def get_new_address(address_label)
    HTTParty.get("#{DOGEAPI_BASE_URI}a=get_new_address&address_label=#{address_label}").to_s
  end

  def self.get_my_addresses
    JSON.parse(HTTParty.get("#{DOGEAPI_BASE_URI}a=get_my_addresses").body)
  end

  def self.get_address_received(deposit_address)
    HTTParty.get("#{DOGEAPI_BASE_URI}a=get_address_received&payment_address=#{deposit_address}").body
  end

  def self.redis
    Redis.current
  end
end

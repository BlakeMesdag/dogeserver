class Account < ActiveRecord::Base
  has_many :transactions

  before_validation :fetch_deposit_address

  validates :name, :key, :deposit_address, presence: true
  validates :name, uniqueness: true

  def balance
    transactions.sum(:amount)
  end

  def serializable_hash(options)
    new_options = (options || {}).merge(except: [:id, :key, :updated_at, :created_at, :deposit_address])
    super new_options
  end

  private

  def fetch_deposit_address
    response = HTTParty.get("https://www.dogeapi.com/wow/?api_key=#{Settings::KEYS['DOGEAPI_API_KEY']}&a=get_new_address&address_label=#{name}")
  
    self.deposit_address = response.to_s
  end
end

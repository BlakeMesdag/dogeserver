module DogeAPI
  include HTTParty
  extend self

  base_uri "https://www.dogeapi.com/wow/?api_key=#{Settings::KEYS['DOGEAPI_API_KEY']}&a="

  def get_new_address(address_label)
    get("get_new_address&address_label=#{address_label}").parsed_response
  end

  def get_my_addresses
    get("get_my_addresses").parsed_response
  end

  def get_address_received(deposit_address)
    get("get_address_received&payment_address=#{deposit_address}").parsed_response
  end
end

module DogeAPI
  class UnexpectedResponse < StandardError; end

  include HTTParty
  extend self

  base_uri "https://www.dogeapi.com/wow/?api_key=#{Settings::KEYS['DOGEAPI_API_KEY']}&a="

  def get_new_address(address_label)
    query    = "get_new_address&address_label=#{address_label}"
    response = get(query)
    dog_log(query, response.code)
    response.parsed_response
  end

  def get_address_received(deposit_address)
    query    = "get_address_received&payment_address=#{deposit_address}"
    response = get(query)
    dog_log(query, response.code)
    response.parsed_response
  end

  def withdraw(to, amount)
    query    = "withdraw&amount=#{amount}&payment_address=#{to}"
    response = get(query)
    dog_log(query, response.code)
    response.parsed_response
  end

  private

  def dog_log(message, code)
    Rails.logger.info("[DogAPI] GET #{message} -> #{code}")
  end
end

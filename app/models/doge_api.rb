module DogeAPI
  class UnexpectedResponse < StandardError; end

  include HTTParty
  extend self

  base_uri "https://www.dogeapi.com/wow/?api_key=#{Settings::KEYS['DOGE_API_KEY']}&a="

  def get_new_address(address_label)
    get_with_logging("get_new_address&address_label=#{address_label}")
  end

  def get_address_received(deposit_address)
    get_with_logging("get_address_received&payment_address=#{deposit_address}")
  end

  def withdraw(to, amount)
    get_with_logging("withdraw&amount=#{amount}&payment_address=#{to}")
  end

  private

  def get_with_logging(query)
    response = get(query)
    dog_log(query, response)
    response.parsed_response
  end

  def dog_log(message, response)
    Rails.logger.info("[DogAPI #{response.code}] GET #{message} -> #{response.parsed_response}")
  end
end

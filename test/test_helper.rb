ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  FakeWeb.allow_net_connect = false

  fake_new_address_response = "0db873ddb14c1465b8edf7d4ca101bf0a4"
  FakeWeb.register_uri(:get, /.+dogeapi.+get_new_address.+/, body: fake_new_address_response)

  fake_withdrawal_response = '72b635d73a6d054b030e1899257ce0474eefa94c86e26c9dc349f65a5c4c6cf8'
  FakeWeb.register_uri(:get, /.+dogeapi.+withdraw.+amount.+payment_address/, body: fake_withdrawal_response)

  def small_account
    accounts(:small)
  end

  def large_account
    accounts(:large)
  end
end

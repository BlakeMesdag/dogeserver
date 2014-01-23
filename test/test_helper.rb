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
  FakeWeb.register_uri(:get, /.+dogeapi.+get_new_address.+/, body: "0db873ddb14c1465b8edf7d4ca101bf0")

  def small_account
    accounts(:small)
  end

  def large_account
    accounts(:large)
  end
end

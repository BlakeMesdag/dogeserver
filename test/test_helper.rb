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
  FakeWeb.register_uri(:get, %r|.+dogeapi.+get_new_address.+|, body: "j39fie")

  def small_account
    accounts(:small)
  end

  def large_account
    accounts(:large)
  end
end

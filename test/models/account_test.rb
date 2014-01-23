require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "creating an account" do
    account = Account.new(name: "unicorn-user-9001", key: "secret-key")

    assert account.save
    assert account.deposit_address
  end

  test "balance" do
    small_account.transactions.create(amount: 20)
    small_account.transactions.create(amount: 32)
    small_account.transactions.create(amount: -10)

    assert_equal 142, small_account.balance
  end

  test "fetching balances" do
    small_account.deposited = large_account.deposited = 0.9
    stub_get_address_received_returns(["1.53921539", "1.95831023"])

    assert_difference "small_account.balance + large_account.balance", 1.69752562 do
      Account.fetch_deposits
    end
  end

  private

  def stub_get_address_received_returns(responses)
    fake_responses = Array(responses).map { |r| { body: r, content_type: 'application/json' } }
    FakeWeb.register_uri(:get, %r|.+dogeapi.+get_address_received.+payment_address=.+|, fake_responses)
  end
end

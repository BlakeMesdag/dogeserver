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
end

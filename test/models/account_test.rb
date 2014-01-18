require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "balance" do
    small_account.transactions.create(amount: 20)
    small_account.transactions.create(amount: 32)
    small_account.transactions.create(amount: -10)

    assert_equal 42, small_account.balance
  end
end

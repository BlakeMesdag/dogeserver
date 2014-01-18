require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "no negative balances" do
    transaction = small_account.transactions.new(amount: 2000)

    refute transaction.save
    assert_equal ["is greater than current balance"], transaction.errors[:amount]
  end
end

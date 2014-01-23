require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test "tips adjust balances" do
    assert_difference "small_account.balance", 10 do
      assert_difference "large_account.balance", -10 do
        Tip.create(large_account, small_account, 10)
      end
    end
  end

  test "a too large tip doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(small_account, large_account, 9000)
    end
  end
end

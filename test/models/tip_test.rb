require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test "tips adjust balances" do
    assert_difference "Transaction.count", 2 do
      assert_difference "small_account.balance", 10 do
        assert_difference "large_account.balance", -10 do
          Tip.create!(from: large_account, to: small_account, amount: 10)
        end
      end
    end
  end

  test "a too large tip doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(from: small_account, to: large_account, amount: 9000)
    end
  end

  test "invalid params doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(to: large_account, amount: 1)
    end
  end
end

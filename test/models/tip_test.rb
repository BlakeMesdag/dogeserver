require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test "tips adjust balances" do
    assert_difference "Transaction.count", 2 do
      assert_difference "small_account.balance", 10 do
        assert_difference "large_account.balance", -10 do
          Tip.create(large_account, small_account, 10)
        end
      end
    end
  end

  test "a too large tip doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(small_account, large_account, 9000)
    end
  end

  test "nil from doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(nil, large_account, 1)
    end
  end

  test "nil to doesnt create transactions" do
    assert_no_difference "Transaction.count" do
      Tip.create(small_account, nil, 1)
    end
  end

  test "errors are present after invalid creation" do
    expected_errors = { tip: "Failed to create tip" }

    tip = Tip.create(small_account, large_account, 9000)

    assert_equal expected_errors, tip.errors
  end
end

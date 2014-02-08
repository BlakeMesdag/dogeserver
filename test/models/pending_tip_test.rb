require 'test_helper'

class PendingTipTest < ActiveSupport::TestCase
  test "only accept positive tips" do
    tip = PendingTip.new(to: accounts(:small), from: accounts(:large), amount: -1000)
    assert !tip.valid?
    assert_equal "Amount must be greater than 0", tip.errors.full_messages.to_sentence
  end
end

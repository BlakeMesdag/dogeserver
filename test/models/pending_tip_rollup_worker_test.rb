require 'test_helper'

class PendingTipRollupWorkerTest < ActiveSupport::TestCase
  def setup
    @worker = PendingTipRollupWorker.new
    @account = accounts(:small)
  end

  test "rollup_pending_tips rolls up tips for all accounts with pending tips" do
    @worker.expects(:rollup_pending_tips_for).times(1)
    @worker.rollup_pending_tips
  end

  test "rollup_pending_tips_for rolls up tips for a single account" do
    assert_difference "accounts(:large).balance", 1 do
      @worker.rollup_pending_tips_for(@account)
    end
  end

  test "rollup_pending_tips_for doesn't allow tipping more than your balance" do
    overdrawn_tip = @account.pending_sent_tips.new(to: accounts(:large), amount: 101)
    overdrawn_tip.save(validate: false)

    assert_difference "@account.balance", -1 do
      @worker.rollup_pending_tips_for(@account)
    end

    assert PendingTip.where(id: overdrawn_tip.id).none?
  end
end

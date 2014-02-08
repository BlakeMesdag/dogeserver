require 'test_helper'

class PendingTipRollupWorkerTest < ActiveSupport::TestCase
  def setup
    @worker = PendingTipRollupWorker.new
  end

  test "rollup_pending_tips rolls up tips for all accounts" do
    @worker.expects(:rollup_pending_tips_for).times(2)

    @worker.rollup_pending_tips
  end

  test "rollup_pending_tips_for rolls up tips for a single account" do
    account = accounts(:small)

    assert_difference "accounts(:large).balance", 1 do
      @worker.rollup_pending_tips_for(account)
    end
  end
end

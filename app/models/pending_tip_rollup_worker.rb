class PendingTipRollupWorker
  def initialize(rollup = false)
    rollup_pending_tips if rollup
  end

  def rollup_pending_tips
    Account.find_each do |account|
      rollup_pending_tips_for(account)
    end
  end

  def rollup_pending_tips_for(account)
    account.pending_tips.find_each do |pending_tip|
      account.transaction do
        account.sent_tips.create(to: pending_tip.to, amount: pending_tip.amount)
        pending_tip.destroy
      end
    end
  end
end

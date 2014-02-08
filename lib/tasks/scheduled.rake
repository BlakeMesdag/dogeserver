namespace :scheduled do
  task :fetch_deposits => :environment do
    Account.fetch_deposits
  end

  task :rollup_tips => :environment do
    PendingTip.rollup_tips(true)
  end
end

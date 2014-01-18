namespace :scheduled do
  task :fetch_deposits => :environment do
    Account.fetch_deposits
  end
end

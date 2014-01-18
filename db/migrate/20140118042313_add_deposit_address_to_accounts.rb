class AddDepositAddressToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :deposit_address, :string
  end
end

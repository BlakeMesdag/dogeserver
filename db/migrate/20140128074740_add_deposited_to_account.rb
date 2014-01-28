class AddDepositedToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :deposited, :float, default: 0
  end
end

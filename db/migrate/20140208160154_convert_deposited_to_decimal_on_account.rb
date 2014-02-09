class ConvertDepositedToDecimalOnAccount < ActiveRecord::Migration
  def up
    Account.connection.execute("ALTER TABLE accounts ALTER deposited deposited DECIMAL(30,15) DEFAULT 0")
  end

  def down
    Account.connection.execute("ALTER TABLE accounts ALTER deposited deposited FLOAT")
  end
end

class ConvertAmountToDecimalOnTransactions < ActiveRecord::Migration
  def up
    Account.connection.execute("ALTER TABLE transactions CHANGE amount amount DECIMAL(30,15) DEFAULT 0")
  end

  def down
    Account.connection.execute("ALTER TABLE transactions CHANGE amount amount FLOAT")
  end
end

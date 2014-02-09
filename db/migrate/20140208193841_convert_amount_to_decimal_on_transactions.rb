class ConvertAmountToDecimalOnTransactions < ActiveRecord::Migration
  def up
    Account.connection.execute("ALTER TABLE transactions ALTER amount amount DECIMAL(30,15) DEFAULT 0")
  end

  def down
    Account.connection.execute("ALTER TABLE transactions ALTER amount amount FLOAT")
  end
end

class ConvertAmountToDecimalOnTips < ActiveRecord::Migration
  def up
    Account.connection.execute("ALTER TABLE tips CHANGE amount amount DECIMAL(30,15) DEFAULT 0")
  end

  def down
    Account.connection.execute("ALTER TABLE tips CHANGE amount amount FLOAT")
  end
end

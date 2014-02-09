class ConvertAmountToDecimalOnTips < ActiveRecord::Migration
  def up
    Account.connection.execute("ALTER TABLE tips ALTER amount amount DECIMAL(30,15) DEFAULT 0")
  end

  def down
    Account.connection.execute("ALTER TABLE tips ALTER amount amount FLOAT")
  end
end

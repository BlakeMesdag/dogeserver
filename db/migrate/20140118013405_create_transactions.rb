class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end

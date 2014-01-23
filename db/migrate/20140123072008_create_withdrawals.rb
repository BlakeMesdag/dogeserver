class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.string :to
      t.float :amount
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end

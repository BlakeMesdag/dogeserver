class CreatePendingTips < ActiveRecord::Migration
  def change
    create_table :pending_tips do |t|
      t.decimal :amount, precision: 30, scale: 15, default: 0.0
      t.references :to, index: true
      t.references :from, index: true

      t.timestamps
    end
  end
end

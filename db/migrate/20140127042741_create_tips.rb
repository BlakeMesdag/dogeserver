class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.belongs_to :from, index: true
      t.belongs_to :to, index: true
      t.float :amount
    end
  end
end

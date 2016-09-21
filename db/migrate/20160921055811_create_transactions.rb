class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :bill, index: true
      t.decimal :paid_amt, null: false
      t.timestamps null: false
    end
  end
end

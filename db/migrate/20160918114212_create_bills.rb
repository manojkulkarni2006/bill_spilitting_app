class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :event, null: false
      t.decimal :amount, null: false
      t.date :date, null:false
      t.string :location, null:false
      t.text :comment
      t.timestamps null: false
    end
  end
end

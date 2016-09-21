class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.integer :from_user, null: false
    	t.integer :to_user, null: false
    	t.decimal :paid_amt, null: false
      t.timestamps null: false
    end
  end
end

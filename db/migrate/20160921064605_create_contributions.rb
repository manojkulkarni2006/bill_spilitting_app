class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
    	t.belongs_to :bill, index: true
    	t.integer :from_user, null: false
    	t.integer :to_user, null: false
    	t.decimal :pay_amt, null: false
      t.timestamps null: false
    end
  end
end

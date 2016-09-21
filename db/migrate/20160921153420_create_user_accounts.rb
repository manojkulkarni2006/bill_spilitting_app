class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
    	t.integer :from_user, null: false
    	t.integer :to_user, null: false
    	t.decimal :previous_cf, null: false
      t.timestamps null: false
    end
  end
end

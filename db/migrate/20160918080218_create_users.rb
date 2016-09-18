class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
    User.create(name: 'Amar')
    User.create(name: 'Akbar')
    User.create(name: 'Anthony')
  end
end
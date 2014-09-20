class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email_address, null: false
      t.integer :hashed_screen_name, :limit => 8, null: false, default: 0
      t.timestamps
    end
  end
end

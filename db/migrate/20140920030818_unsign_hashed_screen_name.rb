class UnsignHashedScreenName < ActiveRecord::Migration
  def up
    change_column :users, :hashed_screen_name, 'bigint unsigned', null: false, default: 0
  end

  def down
    change_column :users, :hashed_screen_name, 'bigint signed', null: false, default: 0
  end
end

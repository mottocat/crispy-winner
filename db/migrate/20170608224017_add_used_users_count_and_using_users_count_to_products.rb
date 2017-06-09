class AddUsedUsersCountAndUsingUsersCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :used_users_count, :integer, default: 0, null: false
    add_index :products, :used_users_count
    add_column :products, :using_users_count, :integer, default: 0, null: false
    add_index :products, :using_users_count
  end
end

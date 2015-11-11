class RemoveUidFormUsers < ActiveRecord::Migration
  def up
    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    add_column :users, :provider, :string
    add_index :users, :provider

    add_column :users, :uid, :string
    add_index :users, :uid
  end
end

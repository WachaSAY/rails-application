class AddAccountPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_picture, :string
  end
end

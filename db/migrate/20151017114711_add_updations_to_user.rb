class AddUpdationsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string, unique: true
    add_column :users, :dob, :date
    add_column :users, :gender, :string
  end
end

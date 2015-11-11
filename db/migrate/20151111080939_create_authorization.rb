class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :user
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :profile_page

      t.timestamps null: false
    end
  end
end

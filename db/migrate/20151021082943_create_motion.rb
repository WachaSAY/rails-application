class CreateMotion < ActiveRecord::Migration
  def change
    create_table :motions do |t|
      t.string :subject, null: false, default: ""
      t.text :description
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end

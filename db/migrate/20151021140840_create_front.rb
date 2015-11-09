class CreateFront < ActiveRecord::Migration
  def change
    create_table :fronts do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.integer :category
      t.belongs_to :motion
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end

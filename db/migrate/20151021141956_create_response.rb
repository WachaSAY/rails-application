class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :description, null: false, default: ""
      t.belongs_to :motion
      t.belongs_to :front
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end

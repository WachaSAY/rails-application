class CreateReply < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :description, null: false, default: ""
      t.belongs_to :motion
      t.belongs_to :front
      t.belongs_to :response
      t.belongs_to :comment
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end

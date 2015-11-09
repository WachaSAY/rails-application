class CreateRating < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :rating_value

      t.belongs_to :user
      t.belongs_to :rateable, polymorphic: true

      t.timestamps null: false
    end
  end
end

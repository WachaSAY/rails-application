class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.float :day_hitpoints
      t.float :three_days_hitpoints
      t.float :weekly_hitpoints
      t.float :monthly_hitpoints
      t.float :yearly_hitpoints

      t.timestamps null: false
    end
  end
end

class CreateMention < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :targeting_user_id
      t.integer :target_user_id
      t.boolean :read, default: false
      t.string :show_url

      t.belongs_to :mentionable, polymorphic: true

      t.timestamps null: false
    end
  end
end

class AddFrontOptionsToMotion < ActiveRecord::Migration
  def change
    add_column :motions, :default_fronts_enabled, :boolean
    add_column :motions, :multiple_fronts_enabled, :boolean
  end
end

# D M
# 0 0 - Only one front
# 0 1 - Only one front initially but users can add fronts later on
# 1 0 - Only 3 inital fronts
# 1 1 - Initially 3 fronts but users can add fronts later on

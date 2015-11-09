class Mention < ActiveRecord::Base

  validates :show_url, :targeting_user, :target_user, presence: true

  belongs_to :targeting_user, class_name: :User
  belongs_to :target_user, class_name: :User
  belongs_to :mentionable, polymorphic: true

end

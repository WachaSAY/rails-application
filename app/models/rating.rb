class Rating < ActiveRecord::Base

  validates :rating_value, :user, presence: true

  belongs_to :user
  belongs_to :rateable, polymorphic: true
end

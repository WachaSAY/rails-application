class Comment < ActiveRecord::Base
  validates :description, :response, :user, presence: true
  belongs_to :motion
  belongs_to :front
  belongs_to :response
  belongs_to :user

  has_many :replies

  has_many :rating, as: :rateable

  before_save :associate_motion_and_front

  private
    def associate_motion_and_front
      self.motion = response.motion
      self.front = response.front
    end
end

class Reply < ActiveRecord::Base
  validates :description, :user, :comment, presence: true
  belongs_to :motion
  belongs_to :front
  belongs_to :response
  belongs_to :user
  belongs_to :comment

  has_many :rating, as: :rateable

  before_save :associate_motion_front_and_comment

  private
    def associate_motion_front_and_comment
      self.motion = comment.motion
      self.front = comment.front
      self.response = comment.response
    end
end

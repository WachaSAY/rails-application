class Response < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  validates :description, :motion, :front, :user, presence: true
  belongs_to :motion
  belongs_to :front
  belongs_to :user

  has_many :comments

  has_many :rating, as: :rateable
  has_many :mentions, as: :mentionable, dependent: :destroy

  after_create :set_notification

  private

    def set_notification
      mentions.create(targeting_user: user,
                      target_user: motion.user,
                      show_url: motion_response_path(id))
    end
end

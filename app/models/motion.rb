class Motion < ActiveRecord::Base

  validates :subject, :description, :user, presence: true
  belongs_to :user
  has_many :fronts, dependent: :destroy
  has_many :responses

  has_many :rating, as: :rateable
  has_many :mentions, as: :mentionable

  after_create :create_default_fronts, if: :default_fronts_enabled
  after_create :create_common_front, unless: :default_fronts_enabled

  private
    def create_default_fronts
      fronts.create(name: 'For', category: 0, user: user, description: 'Towards the motion')
      fronts.create(name: 'Against', category: 1, user: user, description: 'Against the motion')
      fronts.create(name: 'Neutral', category: 2, user: user, description: 'Balanced for either For/Against perspective of the motion')
    end

    def create_common_front
      fronts.create(name: 'Common Motion', category: 4, user: user, description: 'Common front')
    end

end

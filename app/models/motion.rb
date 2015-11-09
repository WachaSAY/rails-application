class Motion < ActiveRecord::Base

  validates :subject, :description, :user, presence: true
  belongs_to :user
  has_many :fronts, dependent: :destroy
  has_many :responses

  has_many :rating, as: :rateable
  has_many :mentions, as: :mentionable

  before_create :create_default_fronts

  private
    def create_default_fronts
      fronts.build(name: 'For', category: 0, user: user, description: 'Towards the motion')
      fronts.build(name: 'Against', category: 1, user: user, description: 'Against the motion')
      fronts.build(name: 'Neutral', category: 2, user: user, description: 'Balanced for either For/Against perspective of the motion')
    end

end

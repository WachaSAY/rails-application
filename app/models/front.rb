class Front < ActiveRecord::Base
  FRONT_CATEGORIES = { for: 0, against: 1 , neutral: 2, custom: 3}

  validates :name, :category, :motion, :user, presence: true
  belongs_to :motion
  belongs_to :user

  has_many :responses

  def front_category
    FRONT_CATEGORIES.key(category)
  end

  def front_category=(value)
    self.type = FRONT_CATEGORIES[value]
  end
end

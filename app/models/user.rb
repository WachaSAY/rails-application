class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  devise :omniauthable, omniauth_providers: [:facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: { :case_sensitive => false }


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).limit(1).first
    (return user) if user

    user = User.find_by(email: auth.info.email)
    if user
      user.update_attributes(provider: auth.provider, uid: auth.uid) and return
    end

    User.create({
      email: auth.info.email,
      password: Devise.friendly_token[0,20],
      provider: auth.provider,
      uid: auth.uid,
      first_name: auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    })

  end

  mount_uploader :account_picture, AccountPictureUploader

end

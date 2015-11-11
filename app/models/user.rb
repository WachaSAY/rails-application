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
  validates :username, :email, uniqueness: { case_sensitive: false }

  SOCIALS = {
    facebook: 'Facebook',
    google_oauth2: 'Google',
    twitter: 'Twitter',
    linkedin: 'Linkedin'
  }

  has_many :authorizations

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # def self.from_omniauth(auth)
  #   user = where(provider: auth.provider, uid: auth.uid).limit(1).first
  #   (return user) if user

  #   user = User.find_by(email: auth.info.email)
  #   if user
  #     user.update_attributes(provider: auth.provider, uid: auth.uid) and return
  #   end

  #   password = Devise.friendly_token[0,20]
  #   user = User.new({
  #     email: auth.info.email,
  #     username: auth.info.email,
  #     password: password,
  #     provider: auth.provider,
  #     uid: auth.uid,
  #     first_name: auth.info.name,   # assuming the user model has a name
  #     confirmation_token: Devise.friendly_token[0,20],
  #     confirmation_sent_at: Time.current,
  #     confirmed_at: Time.current
  #   })

  #   # user.skip_confirmation!
  #   if user.save
  #     AuthorizationMailer.omniauth_registration(user, password).deliver_now
  #   end
  #   user
  # end


  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(provider: auth.provider,
                                        uid: auth.uid.to_s # ,
                                        # :token => auth.credentials.token,
                                        # :secret => auth.credentials.secret
                                        ).first_or_initialize
    authorization.profile_page = "facebook.com/#{auth.uid}" unless authorization.persisted?
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        user.skip_confirmation!
        password = user.set_password
        user.fetch_details(auth)
        user.save
      end
      authorization.user = user
      if authorization.save
        AuthorizationMailer.omniauth_registration(user, password).deliver_now
      end
    end
    authorization.user
  end

  mount_uploader :account_picture, AccountPictureUploader

  def fetch_details(auth)
    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name
    self.email = auth.info.email
    self.username = auth.info.email
    # self.photo = URI.parse(auth.info.image)
  end

  def set_password
    self.password = Devise.friendly_token[0, 20]
  end

end

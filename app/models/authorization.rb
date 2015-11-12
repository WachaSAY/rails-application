class Authorization < ActiveRecord::Base
  belongs_to :user

  def resolve_profile_page(auth)
    case auth.provider.to_s
      when 'facebook' then
        self.profile_page = auth.info.urls.Facebook
      when 'google_oauth2' then
        self.profile_page = auth.info.urls.Google
      when 'twitter' then
        self.profile_page = auth.info.urls.Twitter
      else
        self.profile_page = "http://#{provider}.com/#{auth.uid}"
    end
  end
end

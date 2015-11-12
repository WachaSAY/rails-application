class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user #, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end


  def all
    user = User.from_omniauth(env['omniauth.auth'], current_user)
    if user.persisted?
      sign_in user
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: User::SOCIALS[params[:action].to_sym])
      if user.sign_in_count == 1
        redirect_to users_digest_path # first_login_path
      else
        redirect_to users_digest_path # cabinet_path
      end
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  User::SOCIALS.each do |k, _|
    alias_method k, :all
  end

  # def twitter
  #   auth = env['omniauth.auth']
  #   authorization = Authorization.where(provider: auth.provider,
  #                                       uid: auth.uid.to_s # ,
  #                                       # :token => auth.credentials.token,
  #                                       # :secret => auth.credentials.secret
  #                                       )

  #   if authorization.blank?
  #     a = Authorization.new
  #     a.provider = auth.provider
  #     a.uid = auth.uid
  #     a.save
  #     render template: '/users/twitters/new', locals: { a_id: a.id, auth: auth.to_h }
  #   else
  #     user = User.from_omniauth(env['omniauth.auth'], current_user)
  #     if user.persisted?
  #       sign_in user
  #       flash[:notice] = t('devise.omniauth_callbacks.success', kind: 'Twitter')
  #       if user.sign_in_count == 1
  #         redirect_to users_digest_path # first_login_path
  #       else
  #         redirect_to users_digest_path # cabinet_path
  #       end
  #     else
  #       session['devise.user_attributes'] = user.attributes
  #       redirect_to new_user_registration_url
  #     end
  #   end
  # end


  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end


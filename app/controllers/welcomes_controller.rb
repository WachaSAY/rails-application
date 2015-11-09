class WelcomesController < ApplicationController
  before_action :manage_root_view

  def index
    @user = User.new
    @devise_mapping = Devise.mappings[:user]
  end

  private
  def manage_root_view
    (redirect_to users_digest_path) if current_user
  end
end

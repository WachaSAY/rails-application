class Users::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_user, only: [:show]
  before_action :fetch_user_for_edit, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_details_params)
      redirect_to users_account_path, success: 'Account details saved successfully'
    else
      render :edit
    end
  end

  private

  def user_details_params
    params.require(:user).permit(:first_name, :last_name, :dob, :gender, :account_picture)
  end

  def fetch_user
    @user = User.find_by(username: params[:u])
    unless @user
      @user = current_user
      flash.now[:alert] = 'User not found!' if params[:u] != nil
    end
  end

  def fetch_user_for_edit
    @user = current_user
  end
end

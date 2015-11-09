class Users::DigestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @motions = Motion.order(created_at: :desc).includes(:user)
  end
end

class Motion::FrontsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_motion, only: [:new, :create]
  before_action :motion_allows_front_creation?, only: [:new, :create]

  def new
    @front = Front.new
  end

  def create
    @front = Front.new(motion_params.merge(user: current_user))
    @front.motion = @motion
    @front.front_category = :custom
    if @front.save
      redirect_to motion_path(@front.motion), success: 'Front created successfully'
    else
      render :new
    end
  end

  private

  def motion_params
    params.require(:front).permit(:name, :motion)
  end

  def fetch_motion
    @motion = Motion.find_by(id: params[:m])
    (redirect_to :back, alert: 'Motion not found!') unless @motion
  end

  def motion_allows_front_creation?
    (redirect_to :back, alert: 'Invalid request!') unless @motion.multiple_fronts_enabled
  end
end

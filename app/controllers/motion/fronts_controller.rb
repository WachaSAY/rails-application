class Motion::FrontsController < ApplicationController
  before_action :authenticate_user!

  def new
    @front = Front.new
    @front.motion = Motion.find_by(id: params[:m])
  end

  def create
    @front = Front.new(motion_params.merge(user: current_user))
    @front.front_type = :custom
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
end

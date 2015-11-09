class Motion::ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_front, only: [:create, :update]
  before_action :fetch_response, only: [:show, :destroy]
  before_action :fetch_response_for_update, only: [:update]

  def show
    @front = @response.front
    @motion = @response.motion
    @all_responses = @front.responses.reject{ |r| r.id == @response.id }
    @comment = @response.comments.build(user: current_user)
    @reply = Reply.new
  end

  def create
    @response = Response.new(response_params)
    @response.front = @front
    @response.motion = @front.motion
    @response.user = current_user
    if @response.save
      redirect_to motion_path(@response.motion), success: 'Response added successfully'
    else
      redirect_to motion_path(@response.motion)
    end
  end

  def edit
  end

  def update
    if @response.user.id == current_user.id &&
        @response.front.id == @front.id &&
        @response.update(response_params)
      redirect_to motion_path(@response.motion), success: 'Response saved successfully'
    else
      redirect_to motion_path(@response.motion)
    end
  end

  def destroy
    motion = @response.motion
    @response.destroy
    redirect_to motion_path(motion), success: 'Response deleted successfully'
  end

  private

  def response_params
    params.require(:response).permit(:description)
  end

  def fetch_front
    @front = Front.find_by(id: params[:front])
  end

  def fetch_response
    @response = Response.find_by(id: params[:id])
  end

  def fetch_response_for_update
    @response = Response.find_by(id: params[:response][:id])
  end
end

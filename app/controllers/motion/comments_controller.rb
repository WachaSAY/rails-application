class Motion::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_response, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.response = @response
    @comment.user = current_user
    if @comment.save
      redirect_to motion_response_path(@response), success: 'Comment added successfully'
    else
      redirect_to motion_response_path(@response)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def fetch_response
    @response = Response.find_by(id: params[:response])
  end
end

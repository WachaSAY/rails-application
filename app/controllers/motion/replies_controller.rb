class Motion::RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_comment, only: [:create]

  def create
    @reply = Reply.new(reply_params)
    @reply.comment = @comment
    @reply.user = current_user
    if @reply.save
      redirect_to motion_response_path(@comment.response), success: 'reply added successfully'
    else
      redirect_to motion_response_path(@comment.response)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:description)
  end

  def fetch_comment
    @comment = Comment.find_by(id: params[:comment])
  end
end

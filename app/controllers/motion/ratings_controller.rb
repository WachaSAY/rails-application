class Motion::RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :resolve_ratebale, only: [:create]

  def create
    if @rateable
      if !@rateable.rating.where(user: current_user).exists?
        @rating = @rateable.rating.build(rating_value: 1, user: current_user)
        @rating.save
        @cls_name = 'btn btn-xs btn-warning'
      else
        @rateable.rating.where(user: current_user)[0].destroy
        @cls_name = 'btn btn-xs btn-default'
      end
      @element_identifier_class = "#{@rateable.class.to_s.downcase}-#{@rateable.id}-upvote-count"
      @upvotes = @rateable.rating.count
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating_value)
  end

  def resolve_ratebale
    if params[:motion_id]
      @rateable = Motion.find(params[:motion_id])
    elsif params[:response_id]
      @rateable = Response.find(params[:response_id])
    elsif params[:comment_id]
      @rateable = Comment.find(params[:comment_id])
    elsif params[:reply_id]
      @rateable = Reply.find(params[:reply_id])
    end
  end
end

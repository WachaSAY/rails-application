class SearchesController < ApplicationController

  def show
    session[:q] = params[:q].chomp
    @motions = Motion.where('LOWER(subject) LIKE :query', query: "%#{session[:q].chomp.downcase}%")
  end
end

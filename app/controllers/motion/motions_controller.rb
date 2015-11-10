require 'engtagger'

class Motion::MotionsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :fetch_motion, only: [:edit, :update, :show]
  before_action :authenticate_user_for_edit, only: [:edit, :update]

  after_action :populate_tags, only: [:create, :update]

  def index
    @motions = Motion.where(user: current_user).order(created_at: :desc)
  end

  def show
    @for_front = @motion.fronts.where(category: 0).limit(1).first
    @against_front = @motion.fronts.where(category: 1).limit(1).first
    @neutral_front = @motion.fronts.where(category: 2).limit(1).first
    @common_front = @motion.fronts.where(category: 4).limit(1).first
    @response = Response.new
  end

  def new
    @motion = Motion.new
  end

  def create
    @motion = Motion.new(motion_params.merge(user: current_user))
    if @motion.save
      redirect_to motion_path(@motion), success: 'Motion created successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @motion.update(motion_params)
      redirect_to motion_path(@motion), success: 'Motion saved successfully'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def motion_params
    params.require(:motion).permit(:subject, :description, :default_fronts_enabled, :multiple_fronts_enabled)
  end

  def fetch_motion
    @motion = Motion.find_by(id: params[:id])
  end

  def authenticate_user_for_edit
    if current_user && @motion.user.id != current_user.id
      redirect_to :back, alert: 'Access Denied'
    end
  end

  def populate_tags
    tagger = EngTagger.new
    tagged = tagger.add_tags(ActionView::Base.full_sanitizer.sanitize(@motion.description))
    proper_nouns_of_description = tagger.get_proper_nouns(tagged)
    tagged = tagger.add_tags(@motion.subject)
    nouns_from_subject = tagger.get_noun_phrases(tagged)
    ActiveRecord::Base.transaction do
      persist_tags(proper_nouns_of_description)
      persist_tags(nouns_from_subject)
    end
  end

  def persist_tags(tags_hash)
    tags_hash.each do |k, v|
      t = Tag.find_or_initialize_by(name: k)
      t.day_hitpoints = t.day_hitpoints ? t.day_hitpoints + v : v
      t.save
    end
  end
end

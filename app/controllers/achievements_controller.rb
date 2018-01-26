class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]
  before_action :owners_only, only: [:edit, :update, :destroy]

  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.save ? (redirect_to achievement_url(@achievement.id), notice: "Achievement has been created") : (render :new)
  end

  def edit
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement.update_attributes(achievement_params) ? (redirect_to achievement_path(@achievement)) : (render :edit)
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
  end

  def owners_only
    @achievement = Achievement.find(params[:id])
    current_user != @achievement.user ? redirect_to(achievements_path) : (nil)
  end
end
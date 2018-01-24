class AchievementsController < ApplicationController

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
    @achievement = Achievement.find(params[:id])
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    @achievement.update_attributes(achievement_params) ? (redirect_to achievement_path(@achievement)) : (render :edit)
  end

  def destroy
    Achievement.destroy(params[:id])
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
  end
end
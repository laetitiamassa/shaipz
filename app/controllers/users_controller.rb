# encoding UTF-8

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @url_immo = UrlSearchGenerator.new("immoweb")
    @urls = @url_immo.url(@user.maximum_budget, @user.favorite_areas.split(', '), @user.minimum_space)
    @types_building =  @url_immo.type_building(@user.minimum_space)
  end

  def edit
    @user = current_user
    @url_immo = UrlSearchGenerator.new("immoweb")
    @urls = @url_immo.url(@user.maximum_budget, @user.favorite_areas.split(', '), @user.minimum_space)
    @personal_statuses = User.personal_statuses
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = t("profile.update_success")
      redirect_to user_path(@user)
    else
      @personal_statuses = User.personal_statuses
      @url_immo = UrlSearchGenerator.new("immoweb")
      @urls = @url_immo.url(@user.maximum_budget, @user.favorite_areas.split(', '), @user.minimum_space)
      flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

# encoding: UTF-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @url_immo = SearchUrlGenerator.new("immoweb", @user)
    @urls = @url_immo.generate_urls
    @building_types = @url_immo.building_types
  end

  def edit
    @user = current_user
    @url_immo = SearchUrlGenerator.new("immoweb", @user)
    @urls = @url_immo.generate_urls
    @building_types = @url_immo.building_types
    @personal_statuses = User.personal_statuses
    @personal_timing = User.personal_timing
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = t("profile.update_success")
      redirect_to new_project_path
    else
      @url_immo = SearchUrlGenerator.new("immoweb", @user)
      @urls = @url_immo.generate_urls
      @building_types = @url_immo.building_types
      @personal_statuses = User.personal_statuses
      flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

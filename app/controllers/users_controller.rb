# encoding: UTF-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @projects = @user.find_all_projects
    @url_immo = SearchUrlGenerator.new("immoweb", @user)
    @urls = @url_immo.generate_urls
    @building_types = @url_immo.building_types
    @skills = User.skills
    @roles = User.roles
    
  end

  def edit

    @user = current_user
    @url_immo = SearchUrlGenerator.new("immoweb", @user)
    @urls = @url_immo.generate_urls
    @building_types = @url_immo.building_types
    @personal_statuses = User.personal_statuses
    @skills = User.skills
    @roles = User.roles


  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = t("profile.update_success")
      redirect_to stream_path  
    else  
      
      @personal_statuses = User.personal_statuses
      @skills = User.skills
      @roles = User.roles
     
      #flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

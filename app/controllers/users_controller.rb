# encoding UTF-8

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    @personal_statuses = User.personal_statuses
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = t("profile.update_success")
      redirect_to user_path(@user)
    else
      @personal_statuses = User.personal_statuses
      flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

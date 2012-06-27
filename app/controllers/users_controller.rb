class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = t("profile.update_success")
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

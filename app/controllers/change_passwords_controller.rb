class ChangePasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in(@user, :bypass => true)
      flash[:notice] = t("profile.update_success")
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = t("profile.update_errors")
      render :edit
    end
  end
end

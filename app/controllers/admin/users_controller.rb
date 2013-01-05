class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order('created_at ASC')
  end

  def edit
    @user              = User.find(params[:id])
    @personal_statuses = User.personal_statuses
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = t("admin.controller.user.update_success")
      redirect_to admin_users_path
    else
      @personal_statuses = User.personal_statuses
      flash.now[:error]  = t("admin.controller.user.update_error")
      render :edit
    end
  end
end

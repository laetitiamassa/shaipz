class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order('created_at DESC')
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
    @user_active = User.where("current_sign_in_at < ?", 30.days.ago)
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = t("admin.controller.user.destroy_success")
    redirect_to admin_users_path
  end
end

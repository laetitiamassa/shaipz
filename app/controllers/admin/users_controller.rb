class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order('created_at DESC')
    @user_active = User.where("current_sign_in_at < ?", 31.days.ago)
    @user_buying = User.where(:personal_status => "buying")
    @user_ready_but_bank = User.where(:personal_status => "ready_but_bank")
    @user_ready_with_bank = User.where(:personal_status => "ready_with_bank")
    @user_hiding_budget = User.where(:hide_budget => true)
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end


  def edit
    @user              = User.find(params[:id])
    @personal_statuses = User.personal_statuses
    @rationales         = User.rationales
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

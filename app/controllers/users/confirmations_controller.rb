class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def new
  	render :layout => 'special'
  end

  def after_confirmation_path_for(resource_name, resource)
    edit_user_path(resource)
  end
end

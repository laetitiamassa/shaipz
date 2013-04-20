class Users::SessionsController < Devise::SessionsController
  def new
  
  end

  protected

  def after_sign_in_path_for(resource)
    '/stream'
  end
end

class Admin::SessionsController < Devise::SessionsController
  layout 'admin'

  protected

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def default_url_options(options = {})
    {}
  end
end

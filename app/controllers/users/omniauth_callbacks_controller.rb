class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user != nil
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      new_user = User.user_from_facebook(params, session)
      if new_user.save
        sign_in new_user, :event => :authentication
        flash[:notice] =  I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        redirect_to edit_user_path(new_user)
      else
        I18n.t "devise.omniauth_callbacks.error", :kind => "Facebook"
        redirect_to root_path(new_user)
      end

    end
  end
end
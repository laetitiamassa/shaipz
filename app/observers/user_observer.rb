class UserObserver < ActiveRecord::Observer
  def after_create(user)
    NotificationMailer.welcome_user(user).deliver
  end
end

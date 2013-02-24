class UserObserver < ActiveRecord::Observer
  
  observe :user
  attr_accessor :user

#  def initialize(user)
#    @user = user
#  end

#  def after_create(user) 	
#    NotificationMailer.welcome_user(user).deliver
#  end

end
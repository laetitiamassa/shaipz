class UserObserver < ActiveRecord::Observer
  
  observe :user
  attr_accessor :user


#  def initialize(user)
#    @user = user
#  end


#  def welcome(user)
#    if self.confirmed?
#      NotificationMailer.welcome_email(user).deliver
#    end
#  end

def before_save(user)
	@is_new_record = user.new_record?
	true
end

def after_save(user)
	if @is_new_record then
		NotificationMailer.welcome_user(user).deliver
	end
end

end
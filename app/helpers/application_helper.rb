module ApplicationHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
  	@user 
  end

# can't make that work yet
  def readiness(user)
    personal_status = @user.personal_status
    if user.personal_status == "not_buying"
      '10%'
    else
      '70%'
    end
  end

end

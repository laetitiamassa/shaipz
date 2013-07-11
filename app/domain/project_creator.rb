class ProjectCreator
  attr_accessor :project, :owner, :facebook_service

  def initialize(project, facebook_service = nil)
    @project          = project
    @owner            = @project.owner
    @facebook_service = facebook_service  
  end

  def create
    if project.save
      NotificationMailer.after_creation(owner, project).deliver unless project.suggested
      NotificationMailer.create_project(owner, project, users_interested_in_cohousing).deliver if project.cohousing
      NotificationMailer.create_project_in_my_district(owner, project, users_in_district).deliver if has_users_in_district? unless project.suggested
      NotificationMailer.suggest_project_to_lead(owner, project, users_in_district).deliver if has_users_in_district? && project.suggested #I have replaced leaders in district by users in districts, as it doesn't get enough reactions to just send to those who selected leader in their profile 
      facebook_service.post_project_on_wall(project) if facebook_service && project.share_on_facebook
      true
    else
      false
    end
  end

  def users_interested_in_cohousing
    User.where("cohousing = ? AND id != ?", true, owner.id)
  end

  def users_in_district
    User.all.select{ |user| user.zipcodes.include?(project.zipcode) if user.id != owner.id } 
  end 

  def leaders_in_district
   User.where(:role => "leader") if users_in_district
  end

  def has_leaders_in_district?
   leaders_in_district.any?
  end

  def has_users_in_district?
    users_in_district.any?
  end
  
end

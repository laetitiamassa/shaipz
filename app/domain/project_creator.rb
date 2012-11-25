class ProjectCreator
  attr_accessor :project, :owner, :facebook_service

  def initialize(project, facebook_service)
    @project          = project
    @owner            = @project.owner
    @facebook_service = facebook_service
  end

  def create!
    if project.save!
      NotificationMailer.create_project(owner, project, users_interested_in_cohousing).deliver if project.cohousing
      facebook_service.post_project_on_wall(project) if project.share_on_facebook
      true
    else
      false
    end
  end

  def users_interested_in_cohousing
    User.where("cohousing = ? AND id != ?", true, owner.id)
  end
end

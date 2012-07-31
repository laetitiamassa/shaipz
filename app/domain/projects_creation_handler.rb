class ProjectsCreationHandler
  def initialize(project, user)
    @project = project
    @user    = user
  end

  def after_creation_mailing
    if @project.cohousing
      concerned_users = User.where("cohousing = ? AND id != ?", true, @user.id)
      NotificationMailer.create_project(@user, @project, concerned_users).deliver
    end
  end
end

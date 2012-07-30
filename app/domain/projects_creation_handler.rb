class ProjectsCreationHandler

  def initialize project, user
    @project = project
    @user    = user
  end

  def after_creation_mailing
    if @project.cohousing
      users_concerned = User.find(:all, :conditions => [
          "users.cohousing = 't' AND users.id != :id",
          { :id => @user.id }
      ])
      NotificationMailer.create_project(@user, @project, users_concerned).deliver
    end
  end
end
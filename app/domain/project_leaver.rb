class ProjectLeaver
  attr_accessor :participation, :user, :project

  def initialize(project, user)
    @participation = Participation.active.find_by_participant_id_and_project_id(user.id, project.id)
    @user          = user
    @project       = project
  end

  def leave!
    if project.has_user_as_owner?(user)
      disable_project
    else
      disable_participation
    end
  end

  def disable_participation
    participation.disable
    NotificationMailer.leave_participant(user, project).deliver
  end

  def disable_project
    NotificationMailer.destroy_project(user, project).deliver if project.has_participants?
    project.disable
  end
end

class ParticipationsController < ApplicationController
  before_filter :check_project_status, :only => :create

  def create
    @participation = current_user.participations.build(params[:participation])
    facebook_service = FacebookService.new(cookies[:fb_access_token])
    if ParticipationCreator.new(@participation, facebook_service).create!
      flash[:notice] = t("participation.create_success")
      redirect_to @participation.project
    else
      flash[:alert] = t("participation.create_error")
      redirect_to @participation.project
    end
  end

  def destroy
    project = Project.find(params[:id])
    flash[:notice] = leave_project(project)
    redirect_to stream_path
  end

  private

  def leave_project(the_project)
    if the_project.owner == current_user
      if the_project.participants.all.map(&:email) != []
        NotificationMailer.destroy_project(current_user, the_project).deliver
      end
      the_project.destroy
    else
      participation = Participation.find_by_participant_id_and_project_id(current_user.id, the_project.id)
      participation.destroy
      NotificationMailer.leave_participant(current_user, the_project).deliver
    end
    t("participation.destroy_success")
  end

  def check_project_status
    project = Project.find(params[:participation][:project_id])
    redirect_to(new_project_url, :alert => t("participation.project_disabled")) if project.disabled?
  end
end

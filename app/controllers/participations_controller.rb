class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(params[:participation])
    @participation.participant = current_user
    NotificationMailer.new_participant(current_user, @participation.project).deliver
    if @participation.save
      @participation.project.send_to_facebook_wall(session, t("facebook.join"), project_url(@participation.project), t("project.statuses.#{@participation.project.project_status}"), request)
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
end

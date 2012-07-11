class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(params[:participation])
    @participation.participant = current_user
    if @participation.save
      flash[:notice] = t("participation.create_success")

      NotificationMailer.new_participant(current_user, @participation.project).deliver
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
      the_project.destroy
    else
      participation = Participation.find_by_participant_id_and_project_id(current_user.id, the_project.id)
      participation.destroy
    end

    t("participation.destroy_success")
  end
end

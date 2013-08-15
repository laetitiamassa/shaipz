class ParticipationsController < ApplicationController
  before_filter :check_project_status, :only => :create

  def create
    @participation = current_user.participations.build(params[:participation])
    @project = Project.find(params[:participation][:project_id])
    facebook_service = FacebookService.new(cookies[:fb_access_token])
    if ParticipationCreator.new(@participation, facebook_service).create!
      if @project.suggested
        flash[:notice] = t("Great, you run this project now! Click here to get some tips and tricks!")
      else 
        flash[:notice] = t("participation.create_success")
      end
      redirect_to @participation.project
    else
      flash[:alert] = t("participation.create_error")
      redirect_to @participation.project
    end
  end

  def destroy
    project = Project.find(params[:id])
    if ProjectLeaver.new(project, current_user).leave!
      flash[:notice] = t("participation.destroy_success")
      redirect_to stream_path
    end
  end

  private

  def check_project_status
    project = Project.find(params[:participation][:project_id])
    redirect_to(new_project_url, :alert => t("participation.project_disabled")) if project.disabled?
  end

  def show
  end

  def edit
  end
  
end

class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_owner, :only => [:edit, :update]

  def index
    @projects = Project.active
    render 'streams/show'
  end

  def new
    @user = current_user
    @project_statuses = Project.project_statuses
    @project = Project.new
    @event_types = Project.event_types
    @url_immo = SearchUrlGenerator.new("immoweb", @user)
    @urls = @url_immo.generate_urls
    @building_types = @url_immo.building_types
    
  end

  def create
    @project = current_user.projects.build(params[:project])
    facebook_service = FacebookService.new(cookies[:fb_access_token])
    if ProjectCreator.new(@project, facebook_service).create
      flash[:notice] = t("project.create_success")
      redirect_to stream_path
    else
      @user = current_user
      @event_types = Project.event_types
      @project_statuses = Project.project_statuses
      @url_immo = SearchUrlGenerator.new("immoweb", @user)
      @urls = @url_immo.generate_urls
      @building_types = @url_immo.building_types

      #flash[:alert] = t("project.create_error")
      render :new
    end
  end

  def show
    @user = current_user
    @project = Project.find(params[:id])
    @owner = @project.owner
    @participants = @project.owner_and_participants
    
  end

  def edit
    @project = Project.find(params[:id])
    @user = current_user
    @project_statuses = Project.project_statuses
    @event_types = Project.event_types
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      if @project.has_participants?
        NotificationMailer.update_project(current_user, @project).deliver
      end

      flash[:notice] = t("project.update_success")
      redirect_to @project
    else
      @user = current_user
      @project_statuses = Project.project_statuses
      @event_types = Project.event_types
      #flash[:alert] = t("project.update_error")
      render :edit
    end
  end

  private

  def require_owner
    project = Project.find(params[:id])

    unless project.owner == current_user
      flash[:alert] = t("project.must_be_owner")
      redirect_to stream_path
    end
  end
end

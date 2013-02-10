class Admin::ProjectsController < Admin::BaseController
  def index
    @projects = Project.order('created_at ASC')
  end

  def new
    @project          = Project.new
    @project_statuses = Project.project_statuses
    @event_types      = Project.event_types
    @users            = User.all
  end

  def create
    @project = Project.new(params[:project], :as => :admin)

    if ProjectCreator.new(@project).create
      flash[:success] = t("project.create_success")
      redirect_to admin_projects_path
    else
      @project_statuses = Project.project_statuses
      @event_types      = Project.event_types
      @users            = User.all

      flash.now[:error] = t("project.create_error")
      render :new
    end
  end

  def edit
    @project          = Project.find(params[:id])
    @project_statuses = Project.project_statuses
    @event_types      = Project.event_types
    @users            = User.all
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project], :as => :admin)
      if @project.has_participants?
        NotificationMailer.update_project(current_user, @project).deliver
      end

      flash[:success] = t("project.update_success")
      redirect_to admin_projects_path
    else
      @project_statuses = Project.project_statuses
      @event_types      = Project.event_types
      @users            = User.all

      flash.now[:error] = t("project.update_error")
      render :edit
    end
  end
end

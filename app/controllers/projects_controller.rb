class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_owner, :only => :edit

  def new
    @user = current_user
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.owner = current_user
    if @project.save
      flash[:notice] = t("project.create_success")
      redirect_to stream_path
    else
      @user = current_user
      flash[:alert] = t("project.create_error")
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @user = current_user
  end

  private

  def require_owner
    project = Project.find(params[:id])
    unless project.owner == current_user
      flash[:alert] = t("must_be_owner")
      redirect_to stream_path
    end
  end
end

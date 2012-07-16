class ReportsController < ApplicationController
  before_filter :load_reportable

  def index
    @reports = @reportable.reports
  end

  def new
    @report = @reportable.reports.new
    @user = current_user
  end

  def create
    @report =  @reportable.reports.new(params[:report])
    @report.reporter = current_user
    if @report.save
      redirect_to stream_path, :notice => t('report.create_success')
    else
      flash[:alert] = t('report.create_error')
      render :action => 'new'
    end
  end

  private

  def load_reportable
    type, id = request.path.split('/')[1, 2]
    @reportable = type.singularize.classify.constantize.find(id)
  end
end

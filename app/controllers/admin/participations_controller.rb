class Admin::ParticipationsController < Admin::BaseController
  def index
    @participations = Participation.all
  end

  def edit
    @participation = Participation.find(params[:id])
  end

  def update
    @participation = Participation.find(params[:id])

    if @participation.update_attributes(params[:participation])
      flash[:success] = "Participation updated!"
      redirect_to admin_participations_path
    else
      flash.now[:error] = "This participation couldn't be updated."
      render :edit
    end
  end
end

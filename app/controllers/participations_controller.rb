class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(params[:participation])
    @participation.participant = current_user
    if @participation.save
      flash[:notice] = t("participation.create_success")
      NotificationMailer.new_participant(current_user, @participation.project).deliver
      redirect_to stream_path
    else
      flash[:alert] = t("participation.create_error")
      redirect_to stream_path
    end
  end
end

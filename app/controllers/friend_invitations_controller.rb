class FriendInvitationsController < ApplicationController
  def new
    @user = current_user
    @friends = Array.new(5)
  end

  def create
    mail_friends = FriendInvitationHandler.new(current_user,params[:friends],params[:message])
    if mail_friends.send_email
      flash[:notice] = t("friend_invitation.success")
      redirect_to stream_path
    else
      flash[:alert] = t("friend_invitation.error")
      redirect_to new_friend_invitations_path
    end
  end
end

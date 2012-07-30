class FriendInvitationsMailer < ActionMailer::Base
  default from: "Shaipz <no-reply@shaipz.com>"

  def new(user,emails,message) #when a participant is joining
    @user    = user
    @emails = emails
    @message = message
    mail(
      :to =>  @emails,
      :subject => t("friend_invitation.mailer.subject", :user => @user.name)
    )
  end
end

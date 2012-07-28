class FriendInvitationsMailer < ActionMailer::Base
  default from: "no-reply@shaipz.com"

  def new(user,emails,message) #when a participant is joining
    @user    = user
    @emails = emails
    @message = message.gsub(/\n/, '<br />')
    mail(
      :to =>  @emails,
      :cc => @user.email,
      :subject => t("friend_invitation.mailer.subject", :user => @user.name)
    )
  end
end

class FriendInvitationsMailer < ActionMailer::Base
  layout 'mail'
  default from: "Shaipz <hello@shaipz.com>"

  def new(user, emails, message)
    @user    = user
    @emails = emails
    @message = message
    mail(:to =>  @emails,
         :subject => t("friend_invitation.mailer.subject", :user => @user.name))
  end
end

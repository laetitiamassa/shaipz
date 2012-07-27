class FriendInvitationsMailer < ActionMailer::Base
  default from: "no-reply@shaipz.com"

  def new(user,emails,message) #when a participant is joining
    @user    = user
    @emails = emails
    @message = message
    mail(
      :to =>  @emails,
      :subject => "baskab"
    )
  end
end

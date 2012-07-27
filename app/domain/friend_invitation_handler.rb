class FriendInvitationHandler

  def initialize (user, friends, message)
    @user = user
    @friends = friends
    @message = message
  end

  def send_email
    @emails = Array.new
    @friends.each  do |key, value|
      unless value["email"].blank?
        @emails << value["email"]
      end
    end
    if validates_emails_and_message
      FriendInvitationsMailer.new(@user,@emails,@message).deliver
      return true
    else
      return false
    end
  end

  def validates_emails_and_message
    if @emails.empty? || @message.blank?
      return false
    end
    @emails.each do |email|
      unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        return false
      end
    end
    true
  end
end
class NotificationMailer < ActionMailer::Base
  layout 'mail'
  default from: "Shaipz <no-reply@shaipz.com>"

  def new_participant(user,project) #when a participant is joining
    @user    = user
    @project = project
    mail(
      :bcc => @project.owner_and_participants.map(&:email),
      :subject => t("notification.mail.new_participant.subject", :name => @user.name, :project => @project.name)
    )
  end

  def leave_participant(user,project) #when a participant is leaving
    @user    = user
    @project = project
    mail(
      :bcc => @project.owner_and_participants.map(&:email),
      :subject => t("notification.mail.leave_participant.subject", :name => @user.name, :project => @project.name)
    )
  end

  def update_project(user,project) #Owner update smthg on the project
    @user    = user
    @project = project
    mail(
      :bcc => @project.participants.map(&:email),
      :subject => t("notification.mail.update_project.subject", :name => @user.name, :project => @project.name)
    )
  end

  def destroy_project(user,project) #!! Delete after sending
    @project = project
    @user    = user
    mail(
      :bcc => @project.participants.map(&:email),
      :subject => t("notification.mail.destroy_project.subject", :name => @user.name, :project => @project.name)
    )
  end

  def create_project (user, project, users_concerned)
    @project = project
    @user    = user
    mail(
      :to => users_concerned.map(&:email),
      :subjet => t("notification.mail.create_project.subject", :name => @user.name, :project => @project.name)
    )
  end
end

class NotificationMailer < ActionMailer::Base
  default from: "dev@shaipz.com"

  def new_participant(user,project) #when a participant is joining
    @user    = user
    @project = project
    mail(
      :to => project.participants.all.map(&:email),
      :subject => t(:"notification.mail.new_participant.subject", :name => @user.name, :project => @project.name)
    )
  end

  def leave_participant(user,project) #when a participant is leaving
    @user    = user
    @project = project
    mail(
      :to => project.participants.all.map(&:email),
      :subject => t(:"notification.mail.leave_participant.subject", :name => @user.name, :project => @project.name)
    )
  end

  def update_project(project,user) #Owner update smthg on the project
    @project = project
    @user    = user
    mail(
      :to => project.participants.all.map(&:email),
      :subject => t(:"notification.mail.update_project.subject", :name => @user.name, :project => @project.name)
    )
  end

  def destroy_project(project,user) #!! Delete after sending
    @project = project
    @user    = user
    mail(
      :to => project.participants.all.map(&:email),
      :subject => t(:"notification.mail.destroy_project.subject", :name => @user.name, :project => @project.name)
    )
  end
end

class NotificationMailer < ActionMailer::Base
  layout 'mail'
  default from: "Shaipz <no-reply@shaipz.com>"

  def welcome_user(user) #when a new user is successfully registered
    @user = user
    @url_create = path_to_project_new
    @url_join = path_to_home
    @url_profile = path_to_user_profile
    @url_how = path_to_how_it_works
    mail(
      :to => user.email,
      :subject => t("notification.mail.welcome_user.subject")
    )
  end

  def new_participant(user,project) #when a participant is joining
    @user    = user
    @project = project
    mail(
      :bcc => @project.owner_and_participants.map(&:email),
      :subject => t("notification.mail.new_participant.subject", :name => @user.name, :project => @project.name)
    )
  end
  
  def after_participation(user,project) #after joining a project
    @user    = user
    @project = project
    mail(
      :to => user.email,
      :subject => t("notification.mail.after_participation.subject"), 
      :project => @project.name
    )
  end

  def after_creation(user,project) #after having created a new project
    @user    = user
    @project = project
    mail(
      :to => user.email,
      :subject => t("notification.mail.after_creation.subject"),
      :project => @project.name
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
      :bcc => @project.participants_emails,
      :subject => t("notification.mail.update_project.subject", :name => @user.name, :project => @project.name)
    )
  end

  def destroy_project(user,project) #!! Delete after sending
    @project = project
    @user    = user
    mail(
      :bcc => @project.participants_emails,
      :subject => t("notification.mail.destroy_project.subject", :name => @user.name, :project => @project.name)
    )
  end

  def create_project(user, project, users_concerned)
    @project = project
    @user    = user
    mail(
      :bcc => users_concerned.map(&:email),
      :subject => t("notification.mail.create_project.subject", :name => @user.name)
    )
  end
end

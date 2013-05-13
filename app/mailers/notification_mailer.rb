class NotificationMailer < ActionMailer::Base
  layout 'mail'
  default from: "Shaipz <hello@shaipz.com>"

  def welcome_user(user) #when a new user is successfully registered
    @user = user
    mail(
      :to => user.email,
      :subject => t("notification.mail.welcome_user.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder)
    )
  end

  def new_participant(user,project) #when a participant is joining
    @user    = user
    @project = project
    mail(
      :bcc => @project.owner_and_participants.map(&:email),
      :subject => t("notification.mail.new_participant.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder, :project => @project.name)
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
      :subject => t("notification.mail.leave_participant.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder, :project => @project.name)
    )
  end

  def update_project(user,project) #Owner update smthg on the project
    @user    = user
    @project = project
    mail(
      :bcc => @project.participants_emails,
      :subject => t("notification.mail.update_project.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder, :project => @project.name)
    )
  end

  def destroy_project(user,project) #!! Delete after sending
    @project = project
    @user    = user
    mail(
      :bcc => @project.participants_emails,
      :subject => t("notification.mail.destroy_project.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder, :project => @project.name)
    )
  end

  def create_project(user, project, users_concerned)
    @project = project
    @user    = user
    mail(
      :bcc => users_concerned.map(&:email),
      :subject => t("notification.mail.create_project.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder)
    )
  end

  def create_project_in_my_district(user, project, users_concerned)
    @project = project
    @user    = user
    mail(
      :bcc => users_concerned.map(&:email),
      :subject => t("notification.mail.create_project_in_my_district.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder) 
    )
  end

  def suggest_project_to_lead(user, project, users_concerned)
    @project = project
    @user    = user
    mail(
      :bcc => users_concerned.map(&:email),
      :subject => t("notification.mail.suggest_project_to_lead.subject", :name => @user.has_name? ? @user.name : @user.name_placeholder) 
    )
  end

end

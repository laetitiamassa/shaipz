class FacebookService
  attr_accessor :me

  def initialize(access_token)
    @me = FbGraph::User.me(access_token)
    @url_helpers = Rails.application.routes.url_helpers
  end

  def post_project_on_wall(project)
    post_on_wall project_with_message(project, I18n.t("facebook.create"))
  end

  def post_participation_on_wall(participation)
    post_on_wall project_with_message(participation.project, I18n.t("facebook.join"))
  end

  private

  def post_on_wall(message)
    me.feed!(message) if me.access_token
  end

  def project_with_message(project, message)
    { :message => message,
      :picture => project.picture_url(:medium),
      :link => @url_helpers.project_url(project, :host => APP_HOST),
      :name => project.name,
      :description => project.facebook_description }
  end
end

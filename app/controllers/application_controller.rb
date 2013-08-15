class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  comment_destroy_conditions do |comment|
    comment.owner == current_user
  end

  def fellows_in_district
    User.all.select do |user|
      user.id != self.id &&
      (user.zipcodes & self.zipcodes).any?
    end
  end

  def fellows_status
    User.where("users.id != :id AND users.personal_status = :personal_status", { id: self.id, personal_status: self.personal_status })
  end

  def fellows_purpose
    User.where("users.id != :id AND users.rationale = :rationale", { id: self.id, rationale: self.rationale } )
  end

  def fellows
    fellows_in_district | fellows_status | fellows_purpose
  end

  def perfect_fellows
    fellows_in_district && fellows_status && fellows_purpose
  end

  def zipcodes
    favorite_areas.gsub(" ", "").split(",")
  end
  
end

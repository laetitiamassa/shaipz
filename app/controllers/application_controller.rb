class ApplicationController < ActionController::Base
  protect_from_forgery

  unless  ActionController::Base.consider_all_requests_local
    rescue_from Exception, :with => :render_404
  end

  private

  def render_404
     render :template => 'error_pages/404', :layout => false, :status => :not_found
  end
end

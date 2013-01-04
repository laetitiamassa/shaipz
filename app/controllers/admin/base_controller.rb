class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :authenticate_admin!

  def default_url_options(options = {})
    {}
  end
end

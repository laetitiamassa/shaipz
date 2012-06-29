class StreamsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @projects = Project.all
  end
end

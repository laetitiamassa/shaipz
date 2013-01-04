class StreamsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    if (@projects = Project.where(:zipcode => current_user.zipcodes)).blank?
      @projects = Project.all
    end
  end
end

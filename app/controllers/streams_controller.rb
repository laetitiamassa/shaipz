class StreamsController < ApplicationController
  before_filter :authenticate_user!


  def show
    @user = current_user

    if (@projects = Project.active.where(:zipcode => current_user.zipcodes)).any?
      @has_projects_in_district = true
    else
      @projects = Project.active.all
      @has_projects_in_district = false
    end   
  end



end

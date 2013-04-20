class ShaipzsController < ApplicationController
  before_filter :authenticate_user!


  def show
    @user = current_user
    @projects = @user.find_all_projects
  
  end
end

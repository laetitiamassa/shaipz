class AddPeoplePlanRequestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :people_plan_request, :boolean
  end
end

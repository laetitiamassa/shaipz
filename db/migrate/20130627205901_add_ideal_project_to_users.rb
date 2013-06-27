class AddIdealProjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ideal_project, :text
  end
end

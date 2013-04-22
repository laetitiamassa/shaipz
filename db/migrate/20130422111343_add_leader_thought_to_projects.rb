class AddLeaderThoughtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :leader_thought, :text
  end
end

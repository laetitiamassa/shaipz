class ChangeProjects < ActiveRecord::Migration
  def change
    change_column :projects, :owner_id, :integer, :null => true
    change_column :projects, :zipcode, :string, :default => nil
  end
end

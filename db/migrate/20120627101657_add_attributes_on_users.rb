class AddAttributesOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_areas, :string, :null => false, :default => ""
    add_column :users, :maximum_budget, :integer
    add_column :users, :minimum_space, :integer, :null => false, :default => 0
    add_column :users, :cohousing, :boolean, :default => false
  end
end

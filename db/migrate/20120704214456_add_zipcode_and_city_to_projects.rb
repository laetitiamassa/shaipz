class AddZipcodeAndCityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :zipcode, :integer, :null => false, :default => 0
    add_column :projects, :city, :string
  end
end

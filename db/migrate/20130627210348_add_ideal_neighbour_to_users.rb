class AddIdealNeighbourToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ideal_neighbour, :text
  end
end

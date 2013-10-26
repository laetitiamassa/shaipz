class AddGardenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :garden, :boolean
  end
end

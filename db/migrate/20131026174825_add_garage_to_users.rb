class AddGarageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :garage, :boolean
  end
end

class AddNewlyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newly, :boolean
  end
end

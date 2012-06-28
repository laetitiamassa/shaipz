class AddPersonalStatusOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_status, :string
  end
end

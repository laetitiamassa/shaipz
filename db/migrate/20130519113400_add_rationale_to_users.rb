class AddRationaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rationale, :string
  end
end

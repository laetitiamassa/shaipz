class AddWishToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wish, :string
  end
end

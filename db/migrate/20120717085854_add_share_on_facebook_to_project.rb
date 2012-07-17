class AddShareOnFacebookToProject < ActiveRecord::Migration
  def change
    add_column :projects, :share_on_facebook, :boolean, :default => true
  end
end

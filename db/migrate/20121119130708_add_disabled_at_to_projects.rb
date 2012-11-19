class AddDisabledAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :disabled_at, :datetime, :default => nil
  end
end

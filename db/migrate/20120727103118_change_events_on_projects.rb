class ChangeEventsOnProjects < ActiveRecord::Migration
  def change
    add_column :projects, :event_date, :datetime
    add_column :projects, :event_type, :string, :null => false, :default => "visit"
    rename_column :projects, :event, :event_description
    add_column :projects, :note, :text
  end
end

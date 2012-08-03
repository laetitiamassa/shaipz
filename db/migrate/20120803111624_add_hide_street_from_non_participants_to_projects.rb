class AddHideStreetFromNonParticipantsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hide_street_from_non_participants, :boolean, :default => false
  end
end

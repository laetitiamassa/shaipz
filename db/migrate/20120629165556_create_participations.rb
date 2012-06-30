class CreateParticipations < ActiveRecord::Migration
  create_table :participations do |t|
    t.references :participant, :null => false
    t.references :project, :null => false
    t.timestamps
  end
end

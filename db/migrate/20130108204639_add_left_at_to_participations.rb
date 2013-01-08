class AddLeftAtToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :left_at, :datetime
  end
end

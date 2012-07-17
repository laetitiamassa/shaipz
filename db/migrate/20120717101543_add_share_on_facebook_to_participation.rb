class AddShareOnFacebookToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :share_on_facebook, :boolean, :default => true
  end
end

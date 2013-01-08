class Participation < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant, :class_name => "User"

  attr_accessible :project_id, :participant_id, :share_on_facebook, :left_at

  validates :project_id, :participant_id, :presence => true

  scope :active, where(:left_at => nil)

  def disable
    update_attributes(:left_at => Time.now)
  end
end

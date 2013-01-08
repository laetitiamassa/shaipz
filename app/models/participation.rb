class Participation < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant, :class_name => "User"

  attr_accessible :project_id, :participant_id, :share_on_facebook, :left_at

  validates :project_id, :participant_id, :presence => true

  scope :active, where(:left_at => nil)

  def disable
    update_attributes(:left_at => Time.now)
  end

  def participant_name_with_id
    participant.name_or_placeholder_with_id
  end

  def project_name_with_id
    project.name_with_id
  end

  def left?
    left_at.present?
  end
end

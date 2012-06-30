class Participation < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant, :class_name => "User"

  attr_accessible :project_id, :participant_id

  validates :project_id, :participant_id, :presence => true
  validates :participant_id, :uniqueness => { :scope => :project_id }
end

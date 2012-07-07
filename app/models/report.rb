class Report < ActiveRecord::Base
  attr_accessible :content
  belongs_to :reportable, :polymorphic => true
  belongs_to :reporter,   :class_name => "User"

  validates :content, :presence => true
end

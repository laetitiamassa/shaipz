class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"

  has_attached_file :picture, :styles => { :medium => "680x200>", :thumb => "170x50>" }

  validates :owner_id, :name, :total_amount, :maximum_shaipz, :total_space, :presence => true

  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link, :cohousing, :event

  def has_picture?
    picture.present?
  end
end

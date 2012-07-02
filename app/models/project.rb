class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :participations
  has_many :participants, :through => :participations

  has_attached_file :picture, { :styles => { :medium => "680x200#", :thumb => "100x50#" }, :default_url => "/assets/project_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  validates :owner_id, :name, :total_amount, :maximum_shaipz, :total_space, :presence => true

  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link, :cohousing, :event

  default_scope :order => 'updated_at DESC'

  def has_picture?
    picture.present?
  end

  def has_source_link?
    source_link.present?
  end

  def has_participant?(participant)
    participants.include?(participant)
  end

  def priority_order_for_participant(participant)
    participants.index(participant) + 1
  end
end

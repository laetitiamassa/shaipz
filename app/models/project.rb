class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :participations
  has_many :participants, :through => :participations

  has_attached_file :picture, { :styles => { :medium => "680x200#", :thumb => "100x50#" }, :default_url => "/assets/project_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  validates :owner_id, :name, :total_amount, :maximum_shaipz, :total_space, :presence => true

  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link, :cohousing, :event

  default_scope :order => 'updated_at DESC'

  def owner_name
    owner.has_name? ? owner.name : owner.name_placeholder
  end

  def has_picture?
    picture.present?
  end

  def has_source_link?
    source_link.present?
  end

  def has_participant_or_owner?(participant)
    owner_and_participants.include?(participant)
  end

  def priority_order_for_participant(participant)
    owner_and_participants.index(participant) + 1
  end

  def owner_and_participants
    [owner] + participants
  end
end

class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :participations, :dependent => :destroy
  has_many :participants, :through => :participations
  has_many :reports, :as => :reportable
  has_attached_file :picture, { :styles => { :medium => "720x200#", :thumb => "100x50#" }, :default_url => "/assets/project_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  validates :owner_id, :name, :total_amount, :maximum_shaipz, :total_space, :zipcode, :source_link, :event, :presence => true
  validates :zipcode, :length => { :is => 4 }

  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  PROJECT_STATUSES = ["building_discovery", "people_discovery", "interest_confirmation", "feasibility_stamp", "internal_agreement",
                      "global_offer_making", "global_offer_acceptance","sales_agreement","challenges_fixing", "notarial_deed", "move_in"]


  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link, :cohousing, :event, :city, :zipcode, :project_status

  default_scope :order => 'updated_at DESC'

  def self.project_statuses
    PROJECT_STATUSES.map do |status|
      [I18n.t("project.statuses.#{status}"), status]
    end
  end

  def has_project_status?
    project_status.present?
  end

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

  def total_amount=(amount)
    write_attribute(:total_amount, amount.gsub(/[\.,]/, ""))
  end

  def full_address
    "#{address} #{zipcode} #{city}"
  end
end

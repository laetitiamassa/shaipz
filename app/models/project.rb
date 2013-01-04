class Project < ActiveRecord::Base
  PROJECT_STATUSES = ["building_discovery", "people_discovery", "interest_confirmation", "feasibility_stamp", "internal_agreement",
                      "global_offer_making", "global_offer_acceptance","sales_agreement","challenges_fixing", "notarial_deed", "move_in"]

  EVENT_TYPES = ["meeting", "visit", "other"]

  include Round
  belongs_to :owner, :class_name => "User"
  has_many :participations, :dependent => :destroy
  has_many :participants, :through => :participations
  has_many :reports, :as => :reportable
  has_attached_file :picture, { :styles => { :medium => "720x200#", :thumb => "100x50#" }, :default_url => "/assets/project_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  validates :name, :total_amount, :maximum_shaipz, :total_space, :zipcode, :source_link, :event_type, :event_date, :event_description, :owner, :presence => true
  validates_numericality_of :total_amount, :maximum_shaipz, :total_space
  validates :zipcode, :length => { :is => 4 }
  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link,
                  :cohousing, :city, :zipcode, :project_status, :share_on_facebook, :event_description, :event_type, :event_date, :hide_street_from_non_participants

  attr_accessible :name, :picture, :address, :total_amount, :maximum_shaipz, :total_space, :source_link,
                  :cohousing, :city, :zipcode, :project_status, :share_on_facebook, :event_description, :event_type, :event_date, :hide_street_from_non_participants, :owner_id, :as => :admin

  default_scope :order => "updated_at DESC"

  def self.project_statuses
    PROJECT_STATUSES.map do |status|
      [I18n.t("project.statuses.#{status}"), status]
    end
  end

  def self.event_types
    EVENT_TYPES.map do |type|
      [I18n.t("event.types.#{type}"), type]
    end
  end

  def disabled?
    disabled_at.present?
  end

  def has_project_status?
    project_status.present?
  end

  def price_per_shaipz
    round_to_thousands(total_amount / maximum_shaipz)
  end

  def space_per_shaipz
    total_space/maximum_shaipz
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

  def has_user_as_owner?(user)
    user == owner
  end

  def has_participants?
    participants.any?
  end

  def has_participant?(participant)
    participants.include?(participant)
  end

  def participants_emails
    participants.map(&:email)
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

  def event_type
    I18n.t("event.types.#{read_attribute(:event_type)}")
  end

  def event
    "#{I18n.l(event_date, :format => :short) if event_date} #{event_type}: #{event_description}"
  end

  def full_address
    "#{address} #{zipcode} #{city}"
  end

  def short_address
    "#{zipcode} #{city}"
  end

  def picture_url(size = :original)
    if picture.url.match(/^http/)
      picture.url(size)
    else
      "http://#{APP_HOST}#{picture.url(size)}"
    end
  end

  def address_for_user(user)
    if !has_participant_or_owner?(user) && hide_street_from_non_participants?
      short_address
    else
      full_address
    end
  end

  def facebook_description
    I18n.t("facebook.description", :shaipz => maximum_shaipz, :space => space_per_shaipz, :price => price_per_shaipz, :zipcode => zipcode, :city => city)
  end

  def facebook_sharing_url(link, redirect_uri)
    "https://www.facebook.com/dialog/feed?app_id=#{FACEBOOK_APP_ID}&link=#{link}&name=#{name}&caption=Shaipz.com&description=#{facebook_description}&redirect_uri=#{redirect_uri}&picture=#{picture_url(:medium)}"
  end
end

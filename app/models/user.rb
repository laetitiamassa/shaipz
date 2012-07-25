class User < ActiveRecord::Base
  has_many :projects, :foreign_key => "owner_id"
  has_many :reports, :as => :reportable
  has_many :participations, :foreign_key => "participant_id"
  has_many :project_participations, :through => :participations, :source => :project
  PERSONAL_STATUSES = ["not_buying", "looking_for_opportunity", "ready_but_bank", "ready_with_bank", "buying"]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable

  has_attached_file :picture, { :styles => { :medium => "200x200#", :thumb => "50x50#" }, :default_url => "/assets/profile_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)
  validates :favorite_areas, :minimum_space, :maximum_budget, :presence => true
  validates_numericality_of :minimum_space, :maximum_budget, :greater_than => 0
  validates :favorite_areas, :format => { :with => /^\d{4}(?:\s?,\s?\d{4}){0,4}$/ }

  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :cohousing, :favorite_areas, :minimum_space, :maximum_budget, :picture, :name, :personal_status, :hide_budget
  #

  def is_loggued_with_facebook? (session)
    !(session[:fb_access_token].nil?)
  end

  def find_all_projects
    @projects_of_user = project_participations | projects
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    find_by_email(auth.info.email)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.user_from_facebook(params, session)
    facebook_user = User.new
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      facebook_user.name           = data["name"]
      facebook_user.email          = data["email"]
      facebook_user.password       = SecureRandom.urlsafe_base64
      facebook_user.favorite_areas = "1000"
      facebook_user.minimum_space  = true
      facebook_user.maximum_budget = true
      facebook_user.confirmed_at   = Time.now
    end
    facebook_user
  end

  def has_picture?
    picture.present?
  end

  def has_name?
    name.present?
  end

  def has_personal_status?
    personal_status.present?
  end

  def self.personal_statuses
    PERSONAL_STATUSES.map do |status|
      [I18n.t("statuses.#{status}"), status]
    end
  end

  def owner_of_project?(project)
    projects.include?(project)
  end

  def name_placeholder
    email.split("@")[0]
  end

  def maximum_budget=(budget)
    write_attribute(:maximum_budget, budget.gsub(/[\.,]/, ""))
  end

  def zipcodes
    favorite_areas.split(",").map(&:to_i)
  end
end

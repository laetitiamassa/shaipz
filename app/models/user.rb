class User < ActiveRecord::Base
  require 'csv'

  PERSONAL_STATUSES = ["not_buying", "looking_for_opportunity", "ready_but_bank", "ready_with_bank", "buying", "bought"]
  SKILLS = ["negotiation", "legal", "numbers", "organisation", "construction", "other"]
  ROLES = ["leader", "joiner"]
  RATIONALES = ["home", "investment", "office", "workshop", "store", "second_home", "other"]

  has_many :projects, :foreign_key => "owner_id"
  has_many :reports, :as => :reportable
  has_many :participations, :foreign_key => "participant_id"
  has_many :project_participations, :through => :participations, :source => :project
  has_attached_file :picture, { :styles => { :medium => "200x200#", :thumb => "50x50#" }, :default_url => "/assets/profile_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable

  validates :favorite_areas, :minimum_space, :maximum_budget, :presence => true
  validates_numericality_of :minimum_space, :maximum_budget, :greater_than => 0
  validates :favorite_areas, :format => { :with => /^\d{4}(?:\s?,\s?\d{4}){0,50}$/ }
  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :cohousing, :favorite_areas, :minimum_space, :maximum_budget, :picture, :name, :personal_status, :hide_budget, :personal_timing, :skill, :role, :rationale, :ideal_project, :ideal_neighbour, :people_plan_request, :new, :garden, :garage

  def authenticated_with_facebook?(session)
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
      facebook_user.minimum_space  = '50'
      facebook_user.maximum_budget = '150000'
      facebook_user.confirmed_at   = Time.now
    end
    facebook_user
  end

  def has_ideal_project_or_neighbour?
    ideal_project.present? and ideal_neighbour.present?
  end

  def self.skills 
    SKILLS.map do |skill|
      [I18n.t("skills.#{skill}"), skill]
    end
  end

  def has_skill?
    skill.present?
  end

  def self.roles
    ROLES.map do |role|
      [I18n.t("roles.#{role}"), role]
    end
  end

  def has_role?
    role.present?
  end

  def self.rationales
    RATIONALES.map do |rationale|
      [I18n.t("rationales.#{rationale}"), rationale]
    end
  end

  def has_rationale?
    rationale.present?
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

  def has_personal_timing?
    personal_timing.present?
  end
  
  def personal_timing_placeholder
    I18n.t("profile.default_personal_timing")
  end
  
  def personal_timing_or_placeholder
    personal_timing.present? ? personal_timing : personal_timing_placeholder
  end

  def self.personal_statuses
    PERSONAL_STATUSES.map do |status|
      [I18n.t("statuses.#{status}"), status]
    end
  end

  def self.roles 
    ROLES.map do |role|
      [I18n.t("roles.#{role}"), role]
    end
  end

  def has_role?
    role.present?
  end


  def owner_of_project?(project)
    projects.include?(project)
  end

  def name_or_placeholder
    name.present? ? name : name_placeholder
  end

  def name_or_placeholder_with_id
    "##{id} - #{name_or_placeholder}"
  end

  def name_placeholder
    email.split("@")[0]
  end

  def registration_method
    confirmation_sent_at.present? ? :mail : :facebook
  end

  def confirmed?
    confirmed_at.present?
  end

  def signed_in?
    current_sign_in_at.present?
  end


  def signed_in_before?
    last_sign_in_at.present?
  end

  def remembered?
    remember_created_at.present?
  end

  def has_reset_password?
    reset_password_sent_at.present?
  end

  def maximum_budget=(budget)
    write_attribute(:maximum_budget, budget.gsub(/[\.,]/, ""))
  end

  def fellows_in_district
    User.all.select do |user|
      user.id != self.id &&
      (user.zipcodes & self.zipcodes).any?
    end
  end

  def fellows_status
    User.where("users.id != :id AND users.personal_status = :personal_status", { id: self.id, personal_status: self.personal_status })
  end

  def fellows_purpose
    User.where("users.id != :id AND users.rationale = :rationale", { id: self.id, rationale: self.rationale } )
  end

  def fellows
    fellows_in_district | fellows_status | fellows_purpose
  end

  def perfect_fellows
    fellows_in_district && fellows_status && fellows_purpose
  end

  def zipcodes
    favorite_areas.gsub(" ", "").split(",")
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end

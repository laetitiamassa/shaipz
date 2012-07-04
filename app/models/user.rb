class User < ActiveRecord::Base
  has_many :projects, :foreign_key => "owner_id"

  PERSONAL_STATUSES = ["not_buying", "looking_for_opportunity", "ready_but_bank", "ready_with_bank", "buying"]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :picture, { :styles => { :medium => "200x200#", :thumb => "50x50#" }, :default_url => "/assets/profile_missing_:style.png" }.merge!(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment :picture,
    :content_type => { :content_type => /image/ },
    :size => { :less_than => 2.megabytes }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :cohousing, :favorite_areas, :minimum_space, :maximum_budget, :picture, :name, :personal_status
  # attr_accessible :title, :body
  #

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

  def name_placeholder
    email.split("@")[0]
  end

  def maximum_budget=(budget)
    write_attribute(:maximum_budget, budget.gsub(/[\.,]/, ""))
  end
end

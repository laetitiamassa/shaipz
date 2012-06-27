class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :picture, :styles => { :medium => "200x200>", :thumb => "50x50>" }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :cohousing, :favorite_areas, :minimum_space, :maximum_budget, :picture, :name
  # attr_accessible :title, :body
  #

  def has_picture?
    picture.present?
  end
end

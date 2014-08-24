class User < ActiveRecord::Base

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :authentication_keys => [:username]

  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of   :username
  validates_presence_of   :email

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :groups, through: :group_users
  has_many :group_users
  has_many :projects
  has_many :collaborations
  has_many :comments

  def collabos
    Project.where(id: collaborations.map(&:project_id))
  end

  def all_projects
    projects + collabos
  end

  def belongs_to?(group)
    group.users.include?(self)
  end
end

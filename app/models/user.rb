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

  has_many :projects
  has_many :collaborations

  def collabos
    Project.where(id: collaborations.map(&:project_id))
  end
end

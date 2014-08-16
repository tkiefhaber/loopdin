class Group < ActiveRecord::Base
  has_many :users, through: :group_users

  extend FriendlyId
  friendly_id :title, use: :slugged

end


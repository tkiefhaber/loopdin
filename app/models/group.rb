class Group < ActiveRecord::Base
  has_many :users, through: :group_users
  has_many :group_users

  extend FriendlyId
  friendly_id :title, use: :slugged

  def admin?(user)
    group_users.where(user_id: user.id).first.admin
  end

end


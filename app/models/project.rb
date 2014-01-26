class Project < ActiveRecord::Base
  belongs_to :user
  has_many :versions
  default_scope { order('created_at DESC') }
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :version
  default_scope { order('start_time ASC') }
end

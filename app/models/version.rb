class Version < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  default_scope { order('created_at DESC') }
  has_attached_file :file, bucket: 'loopdin'
  validates_attachment_presence :file
  validates_attachment_content_type :file,
    :content_type => ['video/mp4'],
    :message => "Sorry, right now we only support MP4 video"
end

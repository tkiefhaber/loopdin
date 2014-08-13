class Version < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  default_scope { order('created_at DESC') }
  has_attached_file(:file,
    :bucket => 'loopdin',
    :s3_credentials => {
      :access_key_id => 'AKIAIMINKSVU4KAPUP6A',
      :secret_access_key => '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'
    }
  )
  validates_attachment_presence :file
  validates_attachment_content_type :file,
    :content_type => ['video/mp4'],
    :message => "Sorry, right now we only support MP4 video"
end

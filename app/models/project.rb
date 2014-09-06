class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :versions
  has_many :collaborations, foreign_key: :project_id
  default_scope { order('created_at DESC') }

  validates_uniqueness_of :title, :case_sensitive => false, :scope => :user_id

  extend FriendlyId
  friendly_id :title, use: :slugged

  def collabos
    User.where(id: collaborations.map(&:user_id))
  end

  include AASM
  aasm do
    state :in_progress, :initial => true
    state :submitted
    state :approved

    event :notify do

    end

    event :submit do
      transitions from: [:in_progress, :submitted], to: :submitted, :on_transition => Proc.new {|obj| obj.notify_submission }
    end

    event :needs_work do
      transitions from: [:in_progress, :submitted, :approved], to: :in_progress, :on_transition => Proc.new {|obj| obj.notify_needs_work(current_user) }
    end

    event :approve do
      transitions from: [:in_progress, :submitted, :approved], to: :approved
    end
    alias old_approve approve

    def approve(current_user)
      Proc.new {|obj| obj.notify_approved(current_user) ; obj.update_attributes(approved_at: Time.now) }
      old_approve
    end
  end

  def owner
    User.find(user_id)
  end

  def notify_submission
    ProjectMailer.version_submitted_notification(persons_to_notify, self).deliver
  end

  def notify_needs_work(current_user)
    ProjectMailer.version_needs_work_notification(current_user, persons_to_notify, self).deliver
  end

  def notify_approved(current_user)
    ProjectMailer.version_approved_notification(current_user, persons_to_notify, self).deliver
  end

  def persons_to_notify
    if collabos.present?
      collabos.to_a + [user]
    else
      [user]
    end
  end
end

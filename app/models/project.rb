class Project < ActiveRecord::Base
  belongs_to :user
  has_many :versions
  has_many :collaborations, foreign_key: :project_id
  default_scope { order('created_at DESC') }

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
      transitions from: :in_progress, to: :submitted, :on_transition => Proc.new {|obj| obj.notify_submission }
    end

    event :needs_work do
      transitions from: :submitted, to: :in_progress, :on_transition => Proc.new {|obj| obj.notify_needs_work }
    end

    event :approve do
      transitions from: :submitted, to: :approved, :on_transition => Proc.new {|obj| obj.notify_approval }
    end
  end

  def notify_submission
    ProjectMailer.version_submitted_notification(User.where(id: collaborations.map(&:user_id)), self).deliver
  end

  def notify_needs_work
    ProjectMailer.version_needs_work_notification(User.where(id: collaborations.map(&:user_id)), self).deliver
  end

  def notify_approved
    ProjectMailer.version_approved_notification(User.where(id: collaborations.map(&:user_id)), self).deliver
  end
end

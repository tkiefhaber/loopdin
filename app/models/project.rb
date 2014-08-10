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
      transitions from: :in_progress, to: :submitted
    end

    event :needs_work do
      transitions from: :submitted, to: :in_progress
    end

    event :approve do
      transitions from: :submitted, to: :approved
    end
  end

  def notify_new_project
    
  end
end

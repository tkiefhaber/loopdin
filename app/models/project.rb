class Project < ActiveRecord::Base
  belongs_to :user
  has_many :versions
  default_scope { order('created_at DESC') }
  def self.collabos
    in_progress
  end

  include AASM
  aasm do
    state :in_progress, :initial => true
    state :submitted
    state :approved

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
end

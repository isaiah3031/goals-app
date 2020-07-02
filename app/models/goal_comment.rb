class GoalComment < ApplicationRecord
  validates :subject_id, :author_id, :comment, presence: true
end

class Comment < ApplicationRecord
  validates :comment_id, :comment_type, :text, presence: true
  validates :comment_type, inclusion: { in: %w[user goal] }

  belongs_to :comment, polymorphic: true
end

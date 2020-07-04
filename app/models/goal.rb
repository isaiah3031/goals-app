class Goal < ApplicationRecord
  include Commentable
  validates :author_id, :text, presence: true
  validates :private?, default: false

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User  
end

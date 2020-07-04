class Goal < ApplicationRecord
  validates :author_id, :text, presence: true
  validates :private?, default: false

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :comments, as: :comment
  
end

module Commentable
  extend ActiveSupport::Concern
  
  included do
    has_many :comments, as: :comment
  end
end
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:comment_id) }
  it { should validate_presence_of(:comment_type) }
  it { should validate_presence_of(:text) }
  it do
    should validate_inclusion_of(:comment_type)
      .in_array(%w[user goal])
  end
end

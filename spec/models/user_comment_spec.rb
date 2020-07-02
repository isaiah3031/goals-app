require 'rails_helper'

RSpec.describe UserComment, type: :model do
  it { should validate_presence_of(:subject_id) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:comment) }
end

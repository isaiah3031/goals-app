FactoryBot.define do
  factory :goal_comment do
    author_id { 1 }
    subject_id { 1 }
    comment { "MyText" }
  end
end

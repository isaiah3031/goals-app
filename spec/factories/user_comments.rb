FactoryBot.define do
  factory :user_comment do
    author_id { 1 }
    subject_id { 1 }
    comment { "MyText" }
  end
end

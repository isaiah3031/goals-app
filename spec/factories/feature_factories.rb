FactoryBot.define do
  factory :goal do
    author_id { 1 }
    private? { false }
    text { "MyText" }
  end

  factory :user do
    username { Faker::Name.name }
    password { 'password' }
  end
end

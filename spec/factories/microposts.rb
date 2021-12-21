FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.characters(number: 1..140) }
    association :user
    user_id { user.id }
  end
end

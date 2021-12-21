FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 1..140) }
    association :user
    association :micropost
   
  end
end

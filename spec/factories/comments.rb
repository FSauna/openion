FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 20) }
    association :micropost
  end
end

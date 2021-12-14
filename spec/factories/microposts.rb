FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.characters(number: 20) }
    association :user
    image_id { 'logo.jpg' }
    
  end
end

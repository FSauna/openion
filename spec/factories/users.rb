FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone_number { 12345678909 }
    password { 'password' }
    password_confirmation { 'password' }
    introduction { Faker::Lorem.characters(number: 20) }
  
  end
end

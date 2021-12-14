FactoryBot.define do
  factory :relationship do
    association :following_id
    association :follower_id
  end
end

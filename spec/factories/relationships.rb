FactoryBot.define do
  factory :relationship do
    association :followed_id
    association :follower_id
  end
end

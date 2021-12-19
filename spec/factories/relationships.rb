FactoryBot.define do
  factory :relationship do
    association :user
    follower_id { user.id }
    followed_id { user.id }
  end
end

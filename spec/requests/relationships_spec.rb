require 'rails_helper'

# 修正中

RSpec.describe "Relationships", type: :request do
  
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  
  before do
    sign_in user
  end

  describe '#create' do
    it 'フォローが成功すること' do
      expect do
        Relationship.create({ follower_id: user_2.id, followed_id: user.id})
      end.to change { [user_2.followers.count, user.following.count] }.to [1, 1]
    end
  end

  describe '#destroy' do
    it 'フォロー解除が成功すること' do
      Relationship.create({ follower_id: user_2.id, followed_id: user.id})
      expect(user.following.count).to eq 1
      expect(user_2.followers.count).to eq 1

      Relationship.destroy
      expect(user.following.count).to eq 0
      expect(user_2.followers.count).to eq 0
    end
  end
end

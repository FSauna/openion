require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:like) { create(:like) }

  before do
    sign_in user
  end

  describe "いいねを保存(create)" do
    it "保存が成功すること" do
      expect do
        post micropost_likes_path(name: user.name, micropost_id: micropost.id), xhr: true
        end.to change(Like, :count).by(1)
    end
  end

  describe "いいねした投稿一覧ページを表示(index)" do
    it "リクエストが成功すること" do

      get likes_path
      expect(response.status).to eq 200
    end
  end

  describe "いいねを削除(destroy)" do
    it "削除が成功すること" do
      expect do
          like = create(:like, user_id: user.id, micropost_id: micropost.id)
          expect { delete :destroy, format: :json, params: { micropost_id: micropost.id, user_id: user.id, id: like.id } }.to change{ Like.count }.by(-1)
      end
    end
  end

end

require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:comment) { create(:comment) }
  
  before do
    sign_in user
  end  
  
  describe "コメントを保存(create)" do
    it "保存が成功すること" do
     expect do
        comment = create(:comment, user_id: user.id, micropost_id: micropost.id)
        end.to change(Comment, :count).by(1)
    end
  end
  
  describe "コメントを削除(destroy)" do
    it "削除が成功すること" do
      expect do
          comment = create(:comment, user_id: user.id, micropost_id: micropost.id)
          expect { delete :destroy, format: :json, params: { micropost_id: micropost.id, user_id: user.id, id: comment.id } }.to change{ Comment.count }.by(-1)
      end
    end
  end
  
end

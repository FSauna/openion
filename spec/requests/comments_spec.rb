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
      
      expect(comment).to be_valid
    end
  end
  
  describe "投稿を削除(destroy)" do
    it "削除が成功すること" do
      delete micropost_comment_path comment.id
      expect(response.status).to eq 302
    end  
  end
  
end

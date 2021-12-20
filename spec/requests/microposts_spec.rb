require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  
  before do
    sign_in user
  end  
  
  describe "新規投稿ページを表示(new)" do
    it "リクエストが成功すること" do
      
      get new_micropost_path
      expect(response.status).to eq 200
    end
  end
  
  describe "投稿内容を保存(create)" do
    it "保存が成功すること" do
      
      expect(micropost).to be_valid
    end
  end
  
  describe "投稿一覧ページを表示(index)" do
    it "リクエストが成功すること" do
      
      get microposts_path
      expect(response.status).to eq 200
    end
  end
    
  describe "投稿詳細ページを表示(show)" do
    it "リクエストが成功すること" do
      
      get micropost_path micropost.id
      expect(response.status).to eq 200
    end
  end
  
  describe "投稿編集ページを表示(edit)" do
    it "リクエストが成功すること" do
      
      get edit_micropost_path micropost.id
      expect(response.status).to eq 302
    end  
  end
  
   describe "投稿の編集を更新(update)" do
    let(:micropost_params) { { content: "編集後投稿内容" } }

    it "リクエストが成功すること" do
      
      put micropost_path micropost.id, micropost: micropost_params
      expect(response.status).to eq 302
    end
    it "更新が成功すること" do
      
      put micropost_path micropost.id, micropost: micropost_params
      expect(micropost.reload.content).to eq "編集後投稿内容"
    end
  end
  
  describe "投稿を削除(destroy)" do
    it "削除が成功すること" do
      delete micropost_path micropost.id
      expect(response.status).to eq 302
    end  
  end
  
end

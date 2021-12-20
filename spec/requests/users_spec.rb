require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }

  describe "ログイン(POST /sign_in)に" do
   
    let (:authenticated_user) { create(:user) } #登録済みユーザー
    let (:unauthenticated_user) { build(:user) } #登録していないユーザー
    let (:req_params) { { user: { email: user.email, password: user.password } } }

    context '存在するユーザでログインすると' do
      let (:user) { authenticated_user }

      it '成功すること' do
        post user_session_path, params: req_params
        expect(response.status).to eq 302
      end
    end

    context '存在しないユーザでログインすると' do
      let (:user) { unauthenticated_user }

      it '失敗すること' do
        post user_session_path, params: req_params
        expect(response.status).to eq 200
      end
    end
  end

  describe "新規登録ページ(GET /sign_up)が" do
    it "正しく表示されること" do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
  end

  describe "新規登録(POST /sign_up)で" do
    let (:req_params) { { user: { name: '新規ユーザー', email: 'test@test.co.jp', password: 'password', password_confirmation: 'password' } } }

    context '全て正しい情報を入力した場合' do
      it '登録に成功すること' do
        post user_registration_path, params: req_params
        expect(response.status).to eq 302
      end
    end
  end

  describe "ユーザー詳細ページを表示(show)" do
    it "リクエストが成功すること" do
      sign_in user
      get user_path user.id
      expect(response.status).to eq 200
    end
  end

  describe "ユーザー編集ページを表示(edit)" do
    it "リクエストが成功すること" do
      sign_in user
      get edit_user_path user.id
      expect(response.status).to eq 200
    end
  end
  

  describe "ユーザーの編集を更新(update)" do
    let(:user_params) { { name: "編集後ユーザー名" } }

    it "リクエストが成功すること" do
      sign_in user
      put user_path user.id, user: user_params
      expect(response.status).to eq 302
    end
    it "更新が成功すること" do
      sign_in user
      put user_path user.id, user: user_params
      expect(user.reload.name).to eq "編集後ユーザー名"
    end
  end

  describe "退会確認ページを表示(unsubscribe)" do
    it "リクエストが成功すること" do
      sign_in user
      get unsubscribe_path user.id
      expect(response.status).to eq 200
    end
  end
  
  describe "ユーザーを退会(withdraw)" do
    it "退会が成功すること" do
      sign_in user
      patch withdraw_path user.id
      expect(response.status).to eq 302
    end
  end
  
  describe "フォローページを表示する(following)" do
    it "リクエストが成功すること" do
      sign_in user
      get following_user_path user.id
      expect(response.status).to eq 200
    end
  end
  
  describe "フォロワーページを表示する(following)" do
    it "リクエストが成功すること" do
      sign_in user
      get followers_user_path user.id
      expect(response.status).to eq 200
    end
  end
  
end

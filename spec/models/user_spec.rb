require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_user.valid? }
    
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }

    context 'nameカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.name = ''
        test_user.valid?
        expect(test_user.errors[:name]).to include("can't be blank")
      end
    end

    context 'emailカラム' do
      let(:test_user) { user }
      let(:test_user_2) { user_2 }

      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.email = ''
        test_user.valid?
        expect(test_user.errors[:email]).to include("can't be blank")
      end

      it '一意であること' do
        test_user.email = 'test1@test.co.jp'
        test_user.save
        test_user_2.email = 'test1@test.co.jp'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2).to be_invalid
      end

      it '一意でない場合はエラーが出る' do
        test_user.email = 'test1@test.co.jp'
        test_user.save
        test_user_2.email = 'test1@test.co.jp'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2.errors[:email]).to include("has already been taken")
      end
    end

    context 'passwordカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.password = ''
        test_user.valid?
        expect(test_user.errors[:password]).to include("can't be blank")
      end
      it '6文字以上であること' do
        test_user.password = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '６文字未満の場合はエラーが出る' do
        test_user.password = Faker::Lorem.characters(number: 1)
        test_user.valid?
        expect(test_user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
      it 'パスワードが不一致' do
        test_user.password = "password1"
        test_user.password_confirmation = "password2"
        test_user.valid?
        expect(test_user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Micropostモデルとの関係' do
      let(:target) { :microposts }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      let(:target) { :comments }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context 'Likeモデルとの関係' do
      let(:target) { :likes }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Relationshipモデル(active_relationships)との関係' do
      let(:target) { :active_relationships }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはRelationship' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context 'Relationshipモデル(passive_relationships)との関係' do
      let(:target) { :passive_relationships }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはRelationship' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context '自分がフォローしているユーザーとの関連（自己結合型多対多）' do
      let(:target) { :following }

      it '1:Nとなっている（中間テーブルactive_relationshipsを介すので自己結合型多対多）' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはUser(Follower)' do
        expect(association.class_name).to eq 'User'
      end
    end

    context '自分がフォローされるユーザーとの関連（自己結合型多対多）' do
      let(:target) { :followers }

      it '1:Nとなっている(中間テーブルpassive_relationshipsを介すので自己結合型多対多）' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはUser(Following)' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end

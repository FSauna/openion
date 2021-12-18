require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_comment.valid? }
    
    let(:comment) { create(:comment) }
    

    context 'user_idカラム' do
      let(:test_comment) { comment }

      it '空欄でないこと' do
        test_comment.user_id = ''
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      let(:test_comment) { comment }

      it '空欄でないこと' do
        test_comment.content = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_comment.content = ''
        test_comment.valid?
        expect(test_comment.errors[:content]).to include("can't be blank")
      end
      
      it '140字以内であること' do
        test_comment.content = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
      it '140字以上の場合はエラーが出る' do
        test_comment.content = Faker::Lorem.characters(number: 141)
        test_comment.valid?
        expect(test_comment.errors[:content]).to include("is too long (maximum is 140 characters)")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }

      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'Micropostモデルとの関係' do
      let(:target) { :micropost }

      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
  
end

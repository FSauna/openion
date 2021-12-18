require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_micropost.valid? }
    
    let(:micropost) { create(:micropost) }
    

    context 'user_idカラム' do
      let(:test_micropost) { micropost }

      it '空欄でないこと' do
        test_micropost.user_id = ''
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      let(:test_micropost) { micropost }

      it '空欄でないこと' do
        test_micropost.content = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_micropost.content = ''
        test_micropost.valid?
        expect(test_micropost.errors[:content]).to include("can't be blank")
      end
      
      it '140字以内であること' do
        test_micropost.content = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
      it '140字以上の場合はエラーが出る' do
        test_micropost.content = Faker::Lorem.characters(number: 141)
        test_micropost.valid?
        expect(test_micropost.errors[:content]).to include("is too long (maximum is 140 characters)")
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
  end
  
end

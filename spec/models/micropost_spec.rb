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
      
      it '140字以内であること' do
        test_micropost.content = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '140字以上の場合はエラーが出る' do
        test_micropost.content = Faker::Lorem.characters(number: 1)
        test_micropost.valid?
        expect(test_micropost.errors[:content]).to include("can't be blank")
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

  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship", #フォロー側
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
   has_many :passive_relationships, class_name:  "Relationship", #フォロワー側
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed #フォロー側 'followeds'だと英語的におかしいため
   has_many :followers, through: :passive_relationships, source: :follower #フォロワー側 こっちは :source なくてもよい

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy


  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end

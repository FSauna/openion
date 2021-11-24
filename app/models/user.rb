class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship", #フォロー側
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
   has_many :passive_relationships, class_name:  "Relationship", #フォロワー側
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed #フォロー側 'followeds'だと英語的におかしいため
  has_many :followers, through: :passive_relationships, source: :follower #フォロワー側 こっちは :source なくてもよい

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end


  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy


  def already_liked?(micropost)
    self.likes.exists?(micropost_id: micropost.id)
  end
  
  def active_for_authentication?
    super && (is_active == true)
  end

  validates :name, presence: true

end

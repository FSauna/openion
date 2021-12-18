class Micropost < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user  #誰がいいねされているか

  attachment :image

  acts_as_taggable


  default_scope -> { order(created_at: :desc) } #最新順に表示
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # 検索機能
  def self.search(keyword)
    where(["content like?", "%#{keyword}%"])
  end

  # いいねしたかどうか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end

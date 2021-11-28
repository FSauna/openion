class Micropost < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy #多対多の関係
  has_many :likes
  has_many :liked_users, through: :likes, source: :user #誰がいいねされているか

  attachment :image

  acts_as_taggable
  acts_as_taggable_on :skills, :interests

  default_scope -> { order(created_at: :desc) } #最新順に表示
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.search(keyword)
    where(["content like?", "%#{keyword}%"])
  end

end

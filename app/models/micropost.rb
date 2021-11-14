class Micropost < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy #多対多の関係
  
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  
  def self.search(search)
    search ? where('content LIKE ?', "%#{search}%") : all
  end
  
end

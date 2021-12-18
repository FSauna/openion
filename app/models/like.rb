class Like < ApplicationRecord
  
  belongs_to :micropost
  belongs_to :user
  
  validates_uniqueness_of :micropost_id, scope: :user_id  #一人が一つの投稿に対して一つのいいねだけしかつけられない
  
end

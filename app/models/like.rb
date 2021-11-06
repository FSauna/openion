class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  validates_uniqueness_of :post_id, scope: :user_id  #一人が一つの投稿に対して一つのいいねだけしかつけられない
  
end

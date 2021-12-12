class LikesController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @liked_microposts = current_user.liked_microposts
  end
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    like = current_user.likes.build(micropost_id: params[:micropost_id])
    like.save
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    like.destroy
  end
  
end

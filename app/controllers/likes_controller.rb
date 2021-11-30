class LikesController < ApplicationController
  
  def index
    @liked_microposts = current_user.liked_microposts
  end
  
  def create
    @micropost = Micropost.find(params[:micropost])
    current_user.like(@micropost)
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    current_user.unlike(@micropost)
  end
  
end

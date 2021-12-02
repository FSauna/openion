class LikesController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @liked_microposts = current_user.liked_microposts
  end
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    like = current_user.likes.new(micropost_id: @micropost.id)
    like.save
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    like = current_user.likees.find_by(micropost_id: @micropost.id)
    like.destroy
  end
  
end

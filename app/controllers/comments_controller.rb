class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @micropost = Micropost.find(params[:micropost_id]) 
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = '投稿にコメントしました。'
      redirect_back(fallback_location: root_path)
    else
      @micropost = Micropost.find(params[:micropost_id]) 
　　　@comments = @micropost.comments.includes(:user)
      flash.now[:danger] = '投稿へのコメントに失敗しました。'
      render 'microposts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
end

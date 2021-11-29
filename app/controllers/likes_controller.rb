class LikesController < ApplicationController
  
  def index
    @like_microposts = current_user.like_microposts
  end
  
  def create
    like = Like.new #Likeクラスのインスタンスを作成
    like.user_id = current_user.id #current_userのidを変数に代入
    like.micropost_id = params[:micropost_id]

    if like.save #likeが保存できているかどうかで条件分岐
      redirect_to microposts_path, success: 'いいねしました'
    else
      redirect_to microposts_path, danger: 'いいねに失敗しました'
    end
  end
  
  def destroy
    @like = Like.find_by( user_id: current_user.id, micropost_id: params[:micropost_id])
    @like.destroy
    redirect_to microposts_path, success: 'いいねを取り消しました'
  end
  
end

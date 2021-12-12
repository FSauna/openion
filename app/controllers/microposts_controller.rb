class MicropostsController < ApplicationController

  def new
    @micropost = Micropost.new
    @tags = Micropost.tag_counts_on(:tags)
  end

  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user_id = current_user.id
    @micropost.save!
    redirect_to microposts_path
  end

  def index
    @microposts = Micropost.all.order(created_at: :desc).includes(:user,:tags)
    @user = current_user
    @tags = Micropost.tag_counts_on(:tags).most_used(20)    # タグ一覧表示
    if @tag = params[:tag]   # タグ検索用
      @microposts = Micropost.tagged_with(params[:tag])   # タグに紐付く投稿
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @microposts = Micropost.all
    @like = Like.new
    @comment = Comment.new
    @comments = @micropost.comments.order(created_at: :desc)
    @tags = @micropost.tag_counts_on(:tags)    # 投稿に紐付くタグの表示
  end

  def edit
    @micropost = Micropost.find(params[:id])
    if @micropost.user == current_user
        render "edit"
    else
        redirect_to microposts_path
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      redirect_to micropost_path(@micropost.id)
    else
      render :edit
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to microposts_path
  end

  def search
    @microposts = Micropost.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content, :image, :name, :tag_list)
  end

end

class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
  end
  
  def index
    @posts = Post.all
    @user = current_user
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
        render "edit"
    else
        redirect_to posts_path
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), flash: { notice: 'You have updated book successfully.' }
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  private
  def post_params
    params.require(:post).permit(:body, :image_id)
  end
  
end

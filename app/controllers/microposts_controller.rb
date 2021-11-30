class MicropostsController < ApplicationController

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user_id = current_user.id
    @micropost.save!
    redirect_to microposts_path
  end

  def index
    @microposts = Micropost.all
    @user = current_user
  end

  def show
    @micropost = Micropost.find(params[:id])
    @microposts = Micropost.all
    @like = Like.new
    @comments = @micropost.comments.includes(:user)
    @comment = @micropost.comments.build(user_id: current_user.id) if current_user # form_with 用
  end

  def edit
    @micropost = Microost.find(params[:id])
    if @micropost.user == current_user
        render "edit"
    else
        redirect_to microposts_path
    end
  end

  def update
    @micropost = Microost.find(params[:id])
    if @micropost.update(micropost_params)
      redirect_to micropost_path(@micropost.id), flash: { notice: 'You have updated book successfully.' }
    else
      render :edit
    end
  end

  def destroy
    @micropost = Microost.find(params[:id])
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

class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :check_identity, only: [:edit, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      flash.now.alert = 'Could not create Post'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:notice] = 'Post Successfully Deleted'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def check_identity
    post = Post.find(params[:id])
    unless post.user.username == current_user.username
      flash.alert = 'You can only edit/delete posts that you authored'
      redirect_to post_path
    end
  end

  def authenticate_user!
    unless current_user
      flash.alert = 'You need to SignIn first'
      redirect_to root_path
    end
  end
end
